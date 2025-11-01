from src.ml_api import create_app as create_api_app


def main():
    connection_handler = create_api_app()
    connection_handler.run(host="0.0.0.0", port="3000")

if __name__ == "__main__":
    main()
