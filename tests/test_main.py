from http import HTTPStatus

import pytest
from fastapi.testclient import TestClient

from app.main import app


@pytest.fixture()
def client():
    with TestClient(app) as c:
        yield c


def test_read_root(client):
    response = client.get("/")
    assert response.status_code == HTTPStatus.OK
    assert response.json() == {"Hello": "World"}
