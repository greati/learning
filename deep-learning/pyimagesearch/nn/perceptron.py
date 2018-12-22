import numpy as np

class Perceptron:
    def __init__(self, N, alpha = 0.1):
        self.W = np.random.randn(N + 1)/np.sqrt(N) # sqrt normalization to fasten convergence
        self.alpha = alpha

    def step(self, x):
        return 1 if x > 0 else 0

    def fit(self, X, y, epochs=10):
        # add bias vector
        X = np.c_[X, np.ones((X.shape[0]))]
        # iterate over the epochs number
        for epoch in np.arange(0, epochs):
            # iterate over the design matrix
            for (x, target) in zip(X, y):
                # predict
                p = self.step(np.dot(x, self.W))
                # adjust W
                if (p != target):
                    error = p - target
                    self.W += -self.alpha * error * x

    def predict(self, X, addBias = True):
        # ensure the input is a matrix
        X = np.atleast_2d(X)
        # add bias if necessary
        if (addBias):
            X = np.c_[X, np.ones((X.shape[0]))]
        # predict
        return self.step(np.dot(X, self.W))
