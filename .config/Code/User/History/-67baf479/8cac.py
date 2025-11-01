from src.ml_api import create_app as create_api_app


def main():
    connection_handler = create_api_app()
    connection_handler.run()

if __name__ == "__main__":
    main()
