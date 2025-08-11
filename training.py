#!/usr/bin/env python
import os
from datasets import load_dataset, DatasetDict
from transformers import AutoTokenizer, AutoModelForCausalLM, Trainer, TrainingArguments
from peft import LoraConfig, get_peft_model
from accelerate import Accelerator

# Load tokenizer and model
model_name = "gpt-oss-20b"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.bfloat16, device_map="auto")

# LoRA config
lora_config = LoraConfig(
    r=8,
    lora_alpha=32,
    target_modules=["q_proj", "v_proj"],
    lora_dropout=0.05,
    bias="none",
    task_type="CAUSAL_LM"
)
model = get_peft_model(model, lora_config)

# Load dataset
dataset = load_dataset("json", data_files={"train": "data/train.jsonl", "validation":"data/val.jsonl"})

def preprocess(example):
    return tokenizer(example["text"], truncation=True, max_length=2048, padding="max_length")

tokenized_ds = dataset.map(preprocess, batched=True, remove_columns=["text"])
# Set format
tokenized_ds.set_format(type='torch', columns=['input_ids', 'attention_mask'])

# Training arguments
training_args = TrainingArguments(
    output_dir="./finetuned_gpt_oss",
    per_device_train_batch_size=1,
    gradient_accumulation_steps=8,
    fp16=True,
    bf16=True, # if supported
    learning_rate=5e-5,
    num_train_epochs=3,
    logging_steps=200,
    evaluation_strategy="steps",
    eval_steps=500,
    save_strategy="epoch",
    load_best_model_at_end=True,
)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=tokenized_ds["train"],
    eval_dataset=tokenized_ds["validation"]
)
trainer.train()
