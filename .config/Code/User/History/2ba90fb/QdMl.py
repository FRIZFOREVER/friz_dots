import logging

from flask import Flask
from typing import Tuple

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def create_app():
    app = Flask(__name__)

    logger.info("ml_api is up")

    @app.route("/ping", methods=["GET"])
    def ping() -> Tuple[str, int]:
        logger.info("Ml api ping")
        return "ml api ping", 200

    return app