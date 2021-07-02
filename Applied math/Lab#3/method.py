from matrix import Matrix
import scipy.sparse as scisp


class Method:
    def __init__(self, matrix: Matrix, m_equals: scisp.csr_matrix):
        self.matrix = matrix
        self.m_equals = m_equals
        self.iterations = 0
        self.function_calls = 0
        self.answer = scisp.lil_matrix((1, self.matrix.n))

    def run(self):
        raise NotImplementedError
