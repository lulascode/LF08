from flask import Flask, jsonify
from flask_cors import CORS
import os
import mysql.connector
from mysql.connector import Error as MySQLError

app = Flask(__name__, static_folder="frontend", static_url_path="")
CORS(app)


def get_db_config():
    """
    Read database configuration from environment variables.
    Raise ValueError if any required setting is missing.
    """
    host = os.getenv("MYSQL_HOST", "db")
    database = os.getenv("MYSQL_DATABASE")
    user = os.getenv("MYSQL_USER")
    password = os.getenv("MYSQL_PASSWORD")

    if not all([host, database, user, password]):
        raise ValueError("Database credentials are not fully configured.")

    return {
        "host": host,
        "database": database,
        "user": user,
        "password": password,
    }


def get_db_connection():
    """
    Create a new MariaDB connection using environment configuration.
    This connection must be closed by the caller.
    """
    config = get_db_config()
    return mysql.connector.connect(
        connection_timeout=5,
        **config,
    )


def execute_query(query, params=None):
    """
    Execute a query and return all rows as dictionaries.
    Uses a cursor with dictionary output so the result is JSON-friendly.
    """
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    try:
        cursor.execute(query, params or ())
        return cursor.fetchall()
    finally:
        cursor.close()
        connection.close()


def format_api_response(data=None, status="ok", message=None):
    """
    Standardize API response format across all endpoints.
    """
    response = {"status": status}

    if message is not None:
        response["message"] = message
    if data is not None:
        response["data"] = data

    return jsonify(response)


@app.route("/", methods=["GET"])
def index():
    return app.send_static_file("index.html")


@app.route("/admin", methods=["GET"])
def admin():
    return app.send_static_file("admin.html")


@app.route("/api/status", methods=["GET"])
def status():
    """
    Return basic backend health information.
    """
    return jsonify(
        status="ok",
        service="backend",
        environment=os.getenv("FLASK_ENV", "production"),
    ), 200


@app.route("/api/db-check", methods=["GET"])
def db_check():
    """
    Check whether the backend can connect to the MariaDB database.
    """
    try:
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("SELECT 1")
        cursor.close()
        connection.close()
        return format_api_response(message="Database connection successful."), 200
    except ValueError as err:
        return format_api_response(status="error", message=str(err)), 500
    except MySQLError as err:
        return format_api_response(status="error", message=f"Database connection failed: {err}"), 500


@app.route("/api/pigs", methods=["GET"])
def list_pigs():
    """
    Return all pig records from the `schweine` table.
    """
    try:
        rows = execute_query("SELECT * FROM schweine")
        return format_api_response(data=rows), 200
    except ValueError as err:
        return format_api_response(status="error", message=str(err)), 500
    except MySQLError as err:
        return format_api_response(status="error", message=f"Failed to load pigs: {err}"), 500


@app.route("/api/races", methods=["GET"])
def list_races():
    """
    Return all race records from the `rennen` table.
    """
    try:
        rows = execute_query("SELECT * FROM rennen")
        return format_api_response(data=rows), 200
    except ValueError as err:
        return format_api_response(status="error", message=str(err)), 500
    except MySQLError as err:
        return format_api_response(status="error", message=f"Failed to load races: {err}"), 500


@app.route("/api/videos", methods=["GET"])
def list_videos():
    """
    Return all video records from the `video` table.
    """
    try:
        rows = execute_query("SELECT * FROM video")
        return format_api_response(data=rows), 200
    except ValueError as err:
        return format_api_response(status="error", message=str(err)), 500
    except MySQLError as err:
        return format_api_response(status="error", message=f"Failed to load videos: {err}"), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
