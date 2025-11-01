import logging


from typing import Optional, Dict, Literal
from pydantic import BaseModel, Field, model_validator
from os import getenv

_MODEL_ENV_VARS = {
    "chat": "OLLAMA_REASONING_MODEL",
    "reranker": "OLLAMA_RERANK_MODEL",
    "embeddings": "OLLAMA_EMBEDDING_MODEL",
}

_MODEL_NAMES_DICT = {mode: getenv(env_var) for mode, env_var in _MODEL_ENV_VARS.items()}

class ModelSettings(BaseModel):
    # ---- Connection (applies to ALL calls)
    base_url: str = Field("http://localhost:11434/v1", description="OpenAI-compatible root")
    api_key: Optional[str] = Field(None, description="Local servers often ignore; SDK requires something")
    headers: Dict[str, str] = Field(
        default_factory=dict,
        description="Extra HTTP headers applied to every request",
    )
    timeout_s: float = Field(
        60.0,
        description="Max generation time in seconds before the client aborts",
    )
    max_retries: int = Field(
        3,
        description="Maximum retry attempts for transient request failures",
    )

    # ---- Routing / model id
    api_mode: Literal["chat", "embeddings", "reranker"] = Field(
        ...,
        description="Client mode to call; selects request shape and defaults",
    )
    model: Optional[str] = Field(
        default=None,
        description="Explicit model identifier; defaults to environment-based value for the selected api_mode",
    )

    # ---- Universal sampling defaults (used where applicable)
    temperature: float = Field(
        0.2,
        ge=0.0,
        le=2.0,
        description="Sampling temperature; higher is more random, must be between 0 and 2",
    )
    top_p: float = Field(
        1.0,
        ge=0.0,
        le=1.0,
        description="Nucleus sampling cutoff; probability mass threshold between 0 and 1",
    )

    # ---- CHAT ONLY (ignored by EmbeddingClient)
    chat_json_mode: bool = Field(
        default=False,
        description="Request structured JSON responses if the backend allows it",
    )

    # ---- EMBEDDINGS ONLY (ignored by ChatClient)
    embed_batch_size: int = Field(
        default=128,
        description="Number of MAX inputs batched per embedding call (exceeding will send it as another batch)",
    )

    @model_validator(mode="after")
    def define_model(self):
        if self.model:
            return self

        model = _MODEL_NAMES_DICT.get(self.api_mode)
        if not model:
            # Raise error in case it's not set in .env or it's unreachable
            env_var = _MODEL_ENV_VARS[self.api_mode]
            raise ValueError(f"Environment variable {env_var} not set for api_mode '{self.api_mode}'")

        self.model = model
        return self
    
    @model_validator(mode="after")
    def ensure_mode(self):
        if self.chat_json_mode and self.api_mode != "chat":
            json_mode = self.chat_json_mode
            api_mode = self.api_mode
            logging.warning("Using chat_json_mode = {json_mode} while api_mode = {api_mode}")
            logging.warning("Removing value")
            self.chat_json_mode = None
        return self
