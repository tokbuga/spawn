from datasets import load_dataset
from transformers import AutoTokenizer, AutoModelForCausalLM, Trainer, TrainingArguments

ds = load_dataset("json", data_files="data.jsonl")["train"]

tokenizer = AutoTokenizer.from_pretrained("gpt-oss-20b")
model     = AutoModelForCausalLM.from_pretrained("gpt-oss-20b")

def tokenize(ex):
    return tokenizer(ex["text"], truncation=True, max_length=512)

ds_tok = ds.map(tokenize, batched=True, remove_columns=["text"])

training_args = TrainingArguments(
    output_dir="./fine_tuned",
    overwrite_output_dir=True,
    num_train_epochs=1,
    per_device_train_batch_size=2,
    learning_rate=5e-5,
)

trainer = Trainer(model=model,
                  args=training_args,
                  train_dataset=ds_tok)
trainer.train()
