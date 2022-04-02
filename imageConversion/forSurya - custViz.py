
'''objective:
Have something that combines orignal image with registred images in one file png

rX:\Miller Lab\Surya\CamKIICreOxy\PBS female\stitched_B026
"X:\Miller Lab\Surya\CamKIICreOxy\PBS female\stitched_B026\B026_0010_FITC.png" # file name of the registred with distortion

"X:\Miller Lab\Surya\CamKIICreOxy\PBS female\stitched_B026\output_B026_0010_FITC\Registration_B026_0010_FITC_distorted.png"

main folder
X:\Miller Lab\Surya\CamKIICreOxy\PBS female'''

### add something to not rerun the existing one

#### TODO
# improve to avoid reruning everything 

### dependencies
import matplotlib.pyplot as plt
import os
import glob
import path
import cv2
from matplotlib.gridspec import GridSpec

def apply_brightness_contrast(input_img, brightness = 0, contrast = 0):
   # from https://stackoverflow.com/questions/39308030/how-do-i-increase-the-contrast-of-an-image-in-python-opencv
    if brightness != 0:
        if brightness > 0:
            shadow = brightness
            highlight = 255
        else:
            shadow = 0
            highlight = 255 + brightness
        alpha_b = (highlight - shadow)/255
        gamma_b = shadow
        
        buf = cv2.addWeighted(input_img, alpha_b, input_img, 0, gamma_b)
    else:
        buf = input_img.copy()
    
    if contrast != 0:
        f = 131*(contrast + 127)/(127*(131-contrast))
        alpha_c = f
        gamma_c = 127*(1-f)
        
        buf = cv2.addWeighted(buf, alpha_c, buf, 0, gamma_c)

    return buf

def combinePlots(f):
	plt.ioff()
	fbase = 'output_'+os.path.basename(f).split('.')[0]
	ffolder = os.path.dirname(f)


	imfiles = glob.glob(ffolder +os.sep+ fbase + os.sep + '*.png')
	plt.imshow(plt.imread(imfiles[0]))
	plt.imshow(plt.imread(imfiles[1]))


	fig = plt.figure(figsize=(20, 20))
	gs = GridSpec(nrows=2, ncols=2)
	ax0 = fig.add_subplot(gs[0, 0])
	ax1 = fig.add_subplot(gs[0, 1])
	ax2 = fig.add_subplot(gs[1, :])

	im0 = apply_brightness_contrast(cv2.imread(imfiles[0], cv2.IMREAD_GRAYSCALE), 80, 50)
	im1 = apply_brightness_contrast(cv2.imread(imfiles[1], cv2.IMREAD_GRAYSCALE), 80, 50)

	ax0.imshow(im0, cmap='gray')
	ax1.imshow(im1, cmap='gray')
	ax2.imshow(plt.imread(f)[131:392,26:1157,:])

	# img = plt.imread(f)

	for i in [ax0,ax1,ax2]:
		i.set_axis_off()
	plt.tight_layout()
	fig.savefig(f.split('.')[0]+'_custViz.png')
	plt.close()


### set the environment
mydir = os.getcwd() # get the directory where the script is located 
# place the sit in the parentt directory
# mydir = r'X:\Miller Lab\Surya\CamKIICreOxy' #this can be commented out since it relies on local folder
files = glob.glob(mydir+'/**/*FITC.png', recursive=True)

with concurrent.futures.ProcessPoolExecutor() as executor:
    if __name__ == '__main__':
        executor.map(combinePlots, files)