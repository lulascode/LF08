from flask import Flask, jsonify
from flask_cors import CORS
import os

app = Flask(__name__, static_folder="frontend", static_url_path="")
CORS(app)

@app.route("/", methods=["GET"])
def index():
    return app.send_static_file("index.html")

@app.route("/api/status", methods=["GET"])
def status():
    return jsonify(
        status="ok",
        service="backend",
        environment=os.getenv("FLASK_ENV", "production"),
    ), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
