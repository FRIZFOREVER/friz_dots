# from ml.utils.formats import _rstrip_slash
from ml.configs.model_config import ModelSettings
from ollama import chat, embed


class ReasoningModelClient:
    def __init__(self, settings: ModelSettings):
        pass


class RerankModelClient:
    def __init__(self, settings: ModelSettings):
        pass


class EmbeddingModelClient:
    def __init__(self, settings: ModelSettings):
        pass


def make_client(settings: ModelSettings):
    if settings.api_mode == "chat":
        return 