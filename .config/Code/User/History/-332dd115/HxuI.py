# from ml.utils.formats import _rstrip_slash
from ml.configs.model_config import ModelSettings
from ollama import chat, embed


_CLIENTS = {
    "chat": _ReasoningModelClient,
    "embeddings": _EmbeddingModelClient,
    "reranker": _RerankModelClient,
}


class _ReasoningModelClient:
    def __init__(self, settings: ModelSettings):
        self.s = settings

class _RerankModelClient:
    def __init__(self, settings: ModelSettings):
        self.s = settings

class _EmbeddingModelClient:
    def __init__(self, settings: ModelSettings):
        self.s = settings


def make_client(settings: ModelSettings):
    if settings.api_mode == "chat":
        return _ReasoningModelClient(settings=settings)
    if settings.api_mode == "embeddings":
        return _RerankModelClient(settings=settings)
    if settings.api_mode == "reranker":
        return _EmbeddingModelClient(settings=settings)