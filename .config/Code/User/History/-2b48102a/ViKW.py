from sglang.test.doc_patch import launch_server_cmd
from sglang.utils import wait_for_server, print_highlight, terminate_process
import os

model = os.getenv('CHAT_MODEL_REPO')

server_process, port = launch_server_cmd(
    f"""
python3 -m sglang.launch_server --model-path {model} \
 --host 0.0.0.0 --log-level warning
"""
)

wait_for_server(f"http://localhost:{port}")
