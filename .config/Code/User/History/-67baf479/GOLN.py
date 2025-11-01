import sys
import threading
import time
import urllib.request
from pathlib import Path

from src.api import create_app as create_api_app

BASE_DIR = Path(__file__).resolve().parent
MOCK_SERVER_PATH = BASE_DIR / "mock-server"
if str(MOCK_SERVER_PATH) not in sys.path:
    sys.path.append(str(MOCK_SERVER_PATH))

from server import create_app as create_mock_server_app


def run(app, port):
    app.run(port=port, use_reloader=False)


def main():
    connection_handler = create_api_app()
    mock_server = create_mock_server_app(api_entry_url="http://127.0.0.1:5001/ping")

    threading.Thread(target=run, args=(connection_handler, 5001), daemon=True).start()
    threading.Thread(target=run, args=(mock_server, 5002), daemon=True).start()

    time.sleep(1)
    with urllib.request.urlopen("http://127.0.0.1:5002/ping-backend") as response:
        print(response.read().decode())

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
