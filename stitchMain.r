
library(wholebrain)

cat('This software is designed to stitch multiple set of images \n')
cat('tailored specifically for Hubbs during incell acquisition \n \n')

path <- readline(prompt="copy and paste the directory of interest where images to be stitched are located: ")
cat(path)


cat(' \n \n select which type of stitching to perform \n \n')
cat('[1] option 1 stitch images which have been acquired with a cross pattern (see README) \n')
cat('[2] option 2 stitch images which have been acquired with a rectangular pattern (see README)  \n \n')
inputChoice <- readline(prompt="input choice (eg. 1): ")

# define the percentage of overlap between images
defineOverlap<-0.01
defineOverlap <- readline(prompt="percentage of overlap between images \n for 10 % overlap input 0.01 :")

if(inputChoice ==1){
	source('stitchExtrapattern7.r')
}else{
	source('stitchSimple.r')
}