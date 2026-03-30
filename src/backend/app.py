from flask import Flask, jsonify
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

@app.route("/", methods=["GET"])
def index():
    return jsonify(message="Hello from Flask backend"), 200

@app.route("/api/status", methods=["GET"])
def status():
    return jsonify(
        status="ok",
        service="backend",
        environment=os.getenv("FLASK_ENV", "production"),
    ), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
