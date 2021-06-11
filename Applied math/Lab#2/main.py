from gradient_const import GradientConst
from gradient_split import GradientSplit
from gradient_fastest import GradientFastest
from conjugate_dir import ConjugateDir
from conjugate_grad import ConjugateGrad
from newton import Newton
from plot import plot_and_show, it_plot
import random


def generate_func(k: int, n: int):
    a = [1]
    for i in range(n - 2):
        a.append(random.randint(1, k))
    a.append(k)
    # print(a)

    def funct(x: list):
        for i in range(n):
            return x[i]**2 * a[i]
    return funct


def func(x: list) -> float:
    # return x[0]**2 + x[1]**2 + 3  # [12, -3]
    return 2 * x[0]**2 + 4 * x[1]**2 - 1 * x[0] * x[1] - 5 * x[0]  # [-3, 5]
    pass


method = GradientFastest(func, 0.0001, 2, 0.5, [-3, 5])
method.run()

print("segments: ", method.segments)
print('steps: ', method.iterations)
print("answer: ", method.answer)
print("answer point: ", method.answer_point)
plot_and_show(method)
