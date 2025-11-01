import os

from openai import OpenAI

# Example: read the chat model identifier from the environment at import time.
OLLAMA_CHAT_MODEL = os.getenv("OLLAMA_CHAT_MODEL", "qwen3:0.6b")


class reasoning_model_client:
    def __init__(self):
        self.client = OpenAI(
            base_url="http://ollama:11434/v1/",
            api_key="ollama",  # required for init, not used
        )
        self.model_name = os.getenv("OLLAMA_REASONING_MODEL")
