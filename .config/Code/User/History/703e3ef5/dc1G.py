from pydantic import BaseModel, Field

class ModelConfig(BaseModel):

    # ---- Connection (applies to ALL calls)
    base_url: HttpUrl = Field("http://localhost:11434/v1", description="OpenAI-compatible server root")
    api_key: Optional[str] = Field(None, description="Many local servers ignore this; kept for SDK compat.")
    headers: Dict[str, str] = Field(default_factory=dict)
    timeout_s: float = 30.0
    max_retries: int = 2

    # ---- Routing (applies to ALL calls)
    api_mode: Literal["chat", "embeddings"] = "chat"
    model: str = Field("qwen3:0.6b", description="Provider-visible model id")

    # ---- Universal sampling defaults (used where applicable)
    temperature: float = 0.2
    top_p: float = 1.0

    # ---- CHAT-ONLY (ignored by embedding calls)
    # (Optional) maximum tokens the model can generate for chat completions
    chat_max_tokens: Optional[int] = None  # CHAT ONLY
    # (Optional) deterministic runs if provider supports it
    chat_seed: Optional[int] = None        # CHAT ONLY
    # (Optional) prepend a system prompt to every chat
    chat_system_prompt: Optional[str] = None  # CHAT ONLY
    # (Optional) ask for strict JSON responses if supported
    chat_json_mode: bool = False           # CHAT ONLY

    # ---- EMBEDDINGS-ONLY (ignored by chat calls)
    # (Optional) explicit dimensionality if provider supports it
    embed_dimensions: Optional[int] = None   # EMBEDDINGS ONLY
    # (Optional) L2-normalize vectors after retrieval
    embed_normalize: bool = True             # EMBEDDINGS ONLY
    # (Optional) batch size for large input lists (simple loop batching)
    embed_batch_size: int = 128              # EMBEDDINGS ONLY

    @field_validator("base_url")
    @classmethod
    def strip_trailing_slash(cls, v: str) -> str:
        return v.rstrip("/")