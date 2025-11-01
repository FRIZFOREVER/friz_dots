import logging

from ml.api.app import c


root_logger = logging
# Uvicorn expects an ASGI application object at this path (`ml.main:app`).
app = create_app()
