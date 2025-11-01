from typing import Optional, Dict, Literal, Any
from pydantic import BaseModel, Field

class ModelSettings(BaseModel):
    # ---- Connection (applies to ALL calls)
    base_url: str = Field("http://localhost:11434/v1", description="OpenAI-compatible root")
    api_key: Optional[str] = Field(None, description="Local servers often ignore; SDK requires something")
    headers: Dict[str, str] = Field(default_factory=dict)
    timeout_s: float = Field(60.0, description="max generation time")
    max_retries: int = Field(3, description="amount of retires in case of failure")

    # ---- Routing / model id
    api_mode: Literal["chat", "embeddings", "reranker"]
    model: str

    # ---- Universal sampling defaults (used where applicable)
    temperature: float = 0.2
    top_p: float = 1.0

    # ---- CHAT ONLY (ignored by EmbeddingClient)
    chat_max_tokens: Optional[int] = None        # CHAT ONLY
    chat_seed: Optional[int] = None              # CHAT ONLY
    chat_system_prompt: Optional[str] = None     # CHAT ONLY
    chat_json_mode: bool = False                 # CHAT ONLY

    # ---- EMBEDDINGS ONLY (ignored by ChatClient)
    embed_dimensions: Optional[int] = None       # EMBEDDINGS ONLY
    embed_normalize: bool = True                 # EMBEDDINGS ONLY
    embed_batch_size: int = 128                  # EMBEDDINGS ONLY