from method import Method
import scipy.sparse as scisp


class GaussMethod(Method):
    def run(self):
        n = self.matrix.n

        for step in range(n):
            lower_answer = scisp.lil_matrix((1, n))
            print(self.m_equals[0, 0])
            lower_answer[0, 0] = self.m_equals[0, 0] / self.matrix.decomposed_lower[0, 0]
            for i in range(1, n):
                lower_answer[0, i] = (self.m_equals[0, i] - sum(
                    [self.matrix.decomposed_lower[i, k] * lower_answer[0, k] for k in range(i)])) / \
                                     self.matrix.decomposed_lower[i, i]

            self.answer[0, n - 1] = lower_answer[0, n - 1] / self.matrix.decomposed_upper[n - 1, n - 1]
            for i in range(n - 2, -1, -1):
                self.answer[0, i] = (lower_answer[0, i] - sum(
                    [self.matrix.decomposed_upper[i, k] * self.answer[0, k] for k in range(i + 1, n)])) / \
                                    self.matrix.decomposed_upper[i, i]
