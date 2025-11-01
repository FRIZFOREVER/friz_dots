# from ml.utils.formats import _rstrip_slash
from ml.configs.model_config import ModelSettings
from ollama import chat, embed


class ReasoningModelClient:
    def __init__(self, settings: ModelSettings):
        self.s = settings


class RerankModelClient:
    def __init__(self, settings: ModelSettings):
        self.s = settings


class EmbeddingModelClient:
    def __init__(self, settings: ModelSettings):
        self.s = settings


def make_client(settings: ModelSettings):
    if settings.api_mode == "chat":
        return ReasoningModelClient(settings=settings)
    if settings.api_mode == "embeddings":
        return RerankModelClient(settings=settings)
    if settings.api_mode == "reranker":
        return EmbeddingModelClient(settings=settings)