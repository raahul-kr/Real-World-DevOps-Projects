from app.app import app


def test_home():
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200
    assert response.json["message"] == "GitHub Actions CI/CD project is running"


def test_health():
    client = app.test_client()

    response = client.get("/health")

    assert response.status_code == 200
    assert response.json["status"] == "healthy"


def test_metrics():
    response = app.test_client().get("/metrics")

    assert response.status_code == 200
    assert b"devops_demo_health 1" in response.data
