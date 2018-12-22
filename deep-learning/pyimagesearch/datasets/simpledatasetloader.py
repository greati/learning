import cv2
import numpy as np
import os

''' Assumes the dataset does not surpass RAM capacity of the system.
'''
class SimpleDatasetLoader:
    
    def __init__(self, preprocessors=None):
        self.preprocessors = preprocessors

        if self.preprocessors is None:
            self.preprocessors = []

    def load(self, imagePaths, verbose=-1):
        data = []
        labels = []

        for (i, imagePath) in enumerate(imagePaths):
            image = cv2.imread(imagePath)
            # /path/to/dataset/{class}/{image}.jpg
            label = imagePath.split(os.path.sep)[-2]

            if self.preprocessors is not None:
                for p in self.preprocessors:
                    image = p.preprocess(image)

            data.append(image)
            labels.append(label)

            if verbose > 1 and i > 0 and (i+1)%verbose == 0:
                print("[INFO] processed {}/{}".format(i+1,len(imagePaths)))

        return (np.array(data), np.array(labels))
