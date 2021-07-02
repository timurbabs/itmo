import numpy as np
import scipy.sparse as scisp


class Matrix:
    def __init__(self, matrix: np.array):
        if len(matrix) != len(matrix[0]):
            raise Exception("The matrix has to be quadratic, check if you have equal number of rows and columns.")
        self.matrix = matrix
        self.n = len(self.matrix)
        self.sparse_row_matrix = scisp.csr_matrix(matrix)
        self.decomposed_upper = scisp.csr_matrix((self.n, self.n))
        self.decomposed_lower = scisp.csr_matrix((self.n, self.n))
        self.inverted_matrix = scisp.csr_matrix((self.n, self.n))

    def LU_Decompose(self):
        n = self.n
        U = scisp.csr_matrix((n, n))
        L = scisp.csr_matrix((n, n))

        # Doolittle's method
        # Noticed that every method outputs different L-U factorization, so be careful
        for i in range(n):
            for k in range(i, n):
                sum = 0
                for j in range(i):
                    sum += (L[i, j] * U[j, k])
                U[i, k] = self.sparse_row_matrix[i, k] - sum

            for k in range(i, n):
                if i == k:
                    L[i, i] = 1
                else:
                    sum = 0
                    for j in range(i):
                        sum += (L[k, j] * U[j, i])
                    L[k, i] = (self.sparse_row_matrix[k, i] - sum) / U[i, i]

        self.decomposed_lower = L
        self.decomposed_upper = U

    # Checked with Wolfram, but feel free to re-check
    def LU_Inverse(self):
        n = self.n
        E = scisp.lil_matrix((n, n))
        for i in range(n):
            E[i, i] = 1

        x = scisp.lil_matrix((n, n))
        for step in range(n):
            y = scisp.lil_matrix((1, n))
            y[0, 0] = E[0, step] / self.decomposed_lower[0, 0]
            for i in range(1, n):
                y[0, i] = (
                        (E[i, step] - sum([self.decomposed_lower[i, k] * y[0, k] for k in range(i)])) /
                        self.decomposed_lower[i, i]
                )

            x[n - 1, step] = y[0, n - 1] / self.decomposed_upper[n - 1, n - 1]
            for i in range(n - 2, -1, -1):
                x[i, step] = (
                        (y[0, i] - sum([self.decomposed_upper[i, k] * x[k, step] for k in range(i + 1, n)])) /
                        self.decomposed_upper[i, i]
                )

        self.inverted_matrix = x.tocsr()
