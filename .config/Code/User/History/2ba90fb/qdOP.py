import logging
import os

from flask import Flask
from typing import Tuple

from src.agent.agent import request_chat_completion

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def create_app():
    app = Flask(__name__)

    logger.info("ml_api is up")

    @app.route("/ping", methods=["GET"])
    def ping() -> Tuple[str, int]:
        return "", 200

    return app


app = create_app()


if __name__ == "__main__":
    port = int(os.getenv("ML_API_PORT", "5001"))
    app.run(host="0.0.0.0", port=port, use_reloader=False)
