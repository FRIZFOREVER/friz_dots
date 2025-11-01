from typing import Optional, Dict, List, Literal
from pydantic import BaseModel, Field

class ModelSettings(BaseModel):
    # ---- Connection (applies to ALL calls)
    base_url: str = Field("http://localhost:11434/v1", description="OpenAI-compatible root")
    api_key: Optional[str] = Field(None, description="Local servers often ignore; SDK requires something")
    headers: Dict[str, str] = Field(default_factory=dict)
    timeout_s: float = 30.0
    max_retries: int = 2

    # ---- Routing / model id
    api_mode: Literal["chat", "embeddings"] = "chat"
    model: str = "qwen3:0.6b"

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

    @field_validator("base_url")
    @classmethod
    def _strip_trailing_slash(cls, v: str) -> str:
        return v.rstrip("/")

    def with_overrides(self, **kw: Any) -> "OllamaModelSettings":
        """Return a copy with given fields overridden (handy for per-node tweaks)."""
        data = self.model_dump()
        data.update({k: v for k, v in kw.items() if v is not None})
        return self.__class__(**data)