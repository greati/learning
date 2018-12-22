# This example shows only how to classify a test data instance
# supposing we have the optimized weight matrix W and bias b.

import numpy as np
import cv2
import sys

labels = ["dog","cat","panda"]
np.random.seed(1)

W = np.random.randn(3,3072)
b = np.random.randn(3)

orig = cv2.imread(sys.argv[1])
image = cv2.resize(orig,(32,32)).flatten()

scores = W.dot(image) + b
cv2.putText(orig, "Label: {}".format(labels[np.argmax(scores)]), (10,30), cv2.FONT_HERSHEY_SIMPLEX,
        0.9, (0,255,0), 2)
cv2.imshow("Image", orig)
cv2.waitKey(0)
