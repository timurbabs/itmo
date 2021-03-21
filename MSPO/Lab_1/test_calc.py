import pytest
import calc

class TestCalc():

    def test_div(self):
        with pytest.raises(ZeroDivisionError):
            calc.div(5, 0)
        assert calc.div(0, 5) == 0

    def test_add(self):
        assert calc.add(5, -5) == 0

    def test_sub(self):
        assert calc.sub(5, -5) == 10

    def test_mul(self):
        assert calc.mul(-5, -5) == 25
    
    @pytest.mark.parametrize('input', ["+", "-", "/", "*","0"])
    def test_get_operation(self, input, monkeypatch):
        monkeypatch.setattr('builtins.input', lambda _: input)
        calc.get_operation()

    @pytest.mark.parametrize('input', ["a", "123"])
    def test_get_operation_wrong_values(self, input, monkeypatch):
        with pytest.raises(RuntimeError):
            monkeypatch.setattr('builtins.input', lambda _: input)
            calc.get_operation()

    @pytest.mark.parametrize('input', [["2", "2"], ["4", "4"]])
    def test_get_variables(self, input, monkeypatch):
        monkeypatch.setattr('builtins.input', lambda _: input[0] + input[1])
        calc.get_variables()

    @pytest.mark.parametrize('input', [["d", "4"], ["d", "2"]])
    def test_get_variables_wrong_values(self, input, monkeypatch):
        with pytest.raises(ValueError):
            monkeypatch.setattr('builtins.input', lambda _: input[0] + input[1])
            calc.get_variables()