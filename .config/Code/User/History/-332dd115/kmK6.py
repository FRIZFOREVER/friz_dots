from openai import OpenAI

class reasoning_model_client:
    def __init__(self):
        self.client = OpenAI(
            base_url='http://ollama:11434/v1/',
            api_key='ollama' # required for init, not used
        )
    pass