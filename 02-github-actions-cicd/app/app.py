from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    return {"message": "GitHub Actions CI/CD project is running"}, 200


@app.route("/health")
def health():
    return {"status": "healthy"}, 200


@app.route("/metrics")
def metrics():
    return "devops_demo_health 1\n", 200, {"Content-Type": "text/plain; version=0.0.4"}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
