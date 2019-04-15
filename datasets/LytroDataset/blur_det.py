import cv2

def variance_of_laplacian(image):
	# compute the Laplacian of the image and then return the focus
	# measure, which is simply the variance of the Laplacian
	return cv2.Laplacian(image, cv2.CV_64F).var()
image=cv2.imread("lytro-02-B.jpg")
gray=cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

print(variance_of_laplacian(gray))
if variance_of_laplacian(gray)< 100.0:
	print ('Blurry')
else:
	print ('In-focus')