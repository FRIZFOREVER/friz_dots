import os

from openai import OpenAI
from ml.utils.formats import _rstrip_slash
from ml.configs.model_config import ModelSettings


class _OllamaClient:
    def __init__(self, 
                 settings: ModelSettings):
        self.s = settings
        self.client = OpenAI(
            base_url=self.s.base_url
            api_key=settings.api_key or "local" # Not used in locally deployed models

        )


class reasoning_model_client(_OllamaClient):
    def __init__(self):
        super().__init__("OLLAMA_REASONING_MODEL")


class rerank_model_client(_OllamaClient):
    def __init__(self):
        super().__init__("OLLAMA_RERANK_MODEL")


class embedding_model_client(_OllamaClient):
    def __init__(self):
        super().__init__("OLLAMA_EMBEDDING_MODEL")
