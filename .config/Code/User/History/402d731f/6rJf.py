import logging

from flask import Flask

logger = logging.getLogger(__name__)

logging.basicConfig(level=logging.INFO)


def create_app():
    app = Flask(__name__)

    logger.info("ml_api is up")

    @app.get("/ping")
    def ping():
        logger.info("ml_api got pinged")
        return "backend"

    return app


app = create_app()
