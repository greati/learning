from skimage.exposure import rescale_intensity
import numpy as np
import argparse
import cv2

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="path to the input image")
args = vars(ap.parse_args())

# Some kernels
smallBlur = np.ones((7,7), dtype="float")*(1/(7*7))
largeBlur = np.ones((21,21), dtype="float")*(1/(21*21))
sharpen = np.array((
                    [0,-1,0],
                    [-1,5,-1],
                    [0,-1,0]), dtype="int")
laplacian = np.array((  
                    [0,1,0],
                    [1,-4,1],
                    [0,1,0]), dtype="int")
sobelX = np.array((
                    [-1,0,1],
                    [-2,0,2],
                    [-1,0,1]), dtype="int")
sobelY = np.array((
                    [-1,-2,-1],
                    [0,0,0],
                    [1,2,1]), dtype="int")
emboss = np.array((
                    [-2,-1,0],
                    [-1,1,1],
                    [0,1,2]), dtype="int")

kernels = (
    ("smallBlur", smallBlur),
    ("largeBlur", largeBlur),
    ("sharpen", sharpen),
    ("laplacian", laplacian),
    ("sobelX", sobelX),
    ("sobelY", sobelY),
    ("emboss", emboss))

image = cv2.imread(args["image"])
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

def convolve(image, K):
    # getting the shapes
    (imH, imW) = image.shape
    (kH, kW) = K.shape
    
    # adding padding
    pad = (kW - 1) // 2 
    image = cv2.copyMakeBorder(image, pad, pad, pad, pad, cv2.BORDER_CONSTANT)
    output = np.zeros((imH,imW), dtype="float")

    # actually apply convolution
    for y in np.arange(pad, imH + pad):
        for x in np.arange(pad, imW + pad):
            # taking the image portion covered by the kernel
            roi = image[y - pad : y + pad + 1, x - pad : x + pad + 1]
            # compute the kernel output (sum of element-wise products)
            k = (roi * K).sum()
            # fill the output image
            output[y - pad, x - pad] = k        
            # rescale the output to [0,255] and return
    output = rescale_intensity(output, in_range=(0,255))
    output = (output * 255).astype("uint8")
    return output

for (kernelName, K) in kernels:
    convolveOutput = convolve(gray, K)
    cv2.imshow("Original", gray)
    cv2.imshow("{} - convolved".format(kernelName), convolveOutput)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

