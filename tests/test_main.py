import pytest
from src.main import test_method


def test_test_method():
    result = test_method()
    assert result == "Hello, World!"
