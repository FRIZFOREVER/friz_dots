# main.py
from fastapi import FastAPI
from pydantic import BaseModel
import os

app = FastAPI(title="Example Service")

@app.get("/healthz")
def healthz():
    return {"status": "ok"}

@app.get("/")
def root():
    return {
        "hello": "world",
        "model_repo": os.getenv("CHAT_MODEL_REPO", "unset"),
    }

class Item(BaseModel):
    name: str
    qty: int

@app.post("/items")
def create_item(item: Item):
    # echo back to prove JSON parsing and validation work
    return {"ok": True, "item": item}
