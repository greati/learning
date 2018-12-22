import numpy as np

def sigmoid(z):
    """Computes the sigmoid function output"""
    return 1.0/(1.0 + np.exp(-z))

def sigmoid_deriv(z):
    """The derivative of sigmoid function"""
    return np.exp(-z)/((1+np.exp(-z))**2)

#def sigmoid_deriv(z):
#    """The derivative of sigmoid function at point z, considering that z = sigmoid(x)"""
#    return z * (1 - z)

class MultilayerNeuralNetwork:
    """ Artificial Neural Networks with one or more hidden layers.

    Represents an Artificial Neural Network
    commonly named Multilayer Perceptron, here
    called Multilayer Neural Network to be more precise,
    since it works not only with binary neurons (Perceptrons),
    but with other kinds of neurons, like the Sigmoid ones.
    """
    def __init__(self, architecture, activation, learning_rate = 0.1):
        """
        Initialize network configuration.
        """
        self.W = []
        self.architecture = architecture
        self._architecture = ([i+1 for i in architecture[:-1]]) + [architecture[-1]]   # Include bias
        self.learning_rate = learning_rate
        self.activation = activation

        # Weights initialization
        for i in np.arange(1, len(self._architecture)):
            w = np.random.randn(self._architecture[i-1], self._architecture[i])
            self.W.append(w / np.sqrt(self._architecture[i-1]))

    def __repr__(self):
        return "MultilayerNeuralNetwork: {}".format("-".join([str(l) for l in self.architecture]))

ann = MultilayerNeuralNetwork(architecture=[2,2,1], activation=sigmoid, learning_rate=0.1)
print(ann)
