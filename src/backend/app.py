from flask import Flask, jsonify
from flask_cors import CORS
import os
import mysql.connector

app = Flask(__name__, static_folder="frontend", static_url_path="")
CORS(app)

@app.route("/", methods=["GET"])
def index():
    return app.send_static_file("index.html")

@app.route("/admin", methods=["GET"])
def admin():
    return app.send_static_file("admin.html")

@app.route("/api/status", methods=["GET"])
def status():
    return jsonify(
        status="ok",
        service="backend",
        environment=os.getenv("FLASK_ENV", "production"),
    ), 200

@app.route("/api/db-check", methods=["GET"])
def db_check():
    host = os.getenv("MYSQL_HOST", "db")
    database = os.getenv("MYSQL_DATABASE")
    user = os.getenv("MYSQL_USER")
    password = os.getenv("MYSQL_PASSWORD")

    if not all([host, database, user, password]):
        return jsonify(
            status="error",
            message="Database credentials are not fully configured.",
        ), 500

    try:
        connection = mysql.connector.connect(
            host=host,
            database=database,
            user=user,
            password=password,
            connection_timeout=5,
        )
        cursor = connection.cursor()
        cursor.execute("SELECT 1")
        cursor.close()
        connection.close()
        return jsonify(
            status="ok",
            message="Database connection successful.",
        ), 200
    except mysql.connector.Error as err:
        return jsonify(
            status="error",
            message=f"Database connection failed: {err}",
        ), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
