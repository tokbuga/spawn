import argparse
from transformers import AutoTokenizer, AutoModelForCausalLM

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_name", required=True)
    parser.add_argument("--question", required=True)
    args = parser.parse_args()

    tokenizer = AutoTokenizer.from_pretrained(args.model_name,
                                              use_fast=False)
    model      = AutoModelForCausalLM.from_pretrained(args.model_name)

    prompt = f"Question: {args.question} Answer:"
    inputs = tokenizer(prompt, return_tensors="pt")
    out    = model.generate(**inputs, max_new_tokens=50)
    print(tokenizer.decode(out[0], skip_special_tokens=True))

if __name__ == "__main__":
    main()
