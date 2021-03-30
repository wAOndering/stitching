#############################################################
##/// super stable install for wholebrain
#############################################################
#### NOTE ####
# Rtools40 for version of R>4.0 has finicky compiler could work but need to be tested
# the instruction below work 

#########???????????????############
# unistall oler components
##-- remove/unistall R (all the version) in Control Panel/All Control Panel Items/Programs and Features
##-- remove Rtools (all the version) in Control Panel/All Control Panel Items/Programs and Features
##-- remove cmake (all the version) in Control Panel/All Control Panel Items/Programs and Features

# remove environment variables both:
# User variables for Windows // Path
##-- all Rtools 
##-- all R
##-- all cmake

# System variables // Path
##-- all Rtools 
##-- all R
##-- all cmake
#########???????????????############


#########???????????????############
## install R 3.6.3
##-- https://cran.r-project.org/bin/windows/base/old/3.6.3/
##--IMPORTANT--## during install DO NOT install xi386 (the none x64 version) install everything else

## install Rtools Rtools35.exe
##-- https://cran.r-project.org/bin/windows/Rtools/history.html
##--IMPORTANT--## during install DO NOT install xi386 (the none x64 version) install everything else

## install cmake 3.16.5
##-- https://cmake.org/files/v3.16/cmake-3.16.5-win64-x64.msi

## install fftw 3.3.5
## http://www.fftw.org/install/windows.html
##--  fftw-3.3.5-dll64.zip 64 bit version
## unzip the fftw to c:/fftw (most important are the fftw3.h and libfftw3-3.dll)
#########???????????????############


#########???????????????############
## SET environment variables
# User variables for Windows // Path 
# and System variables // Path
##-- C:\Program Files\R\R-3.6.3\bin\x64
##-- C:\Rtools\bin
##-- C:\Rtools\mingw_64\bin
##-- C:\Program Files\CMake\bin
##-- C:\fftw

## create in System variables a new variable
##-- Variable Name: LIB_FFTW
##-- Variable Value: c:\fftw
#########???????????????############


#########???????????????############
## start cmd (right click as administrator)
## r (to start r)
## run the following command
Sys.which("make") # expected output "C:\\Rtools\\bin\\make.exe"
install.packages("rstan", dependencies = TRUE)
install.packages("devtools", dependencies = TRUE)

## check that Rstan is working
library(rstan)
model<-'data{int N;real y[N];}parameters{real mu;real sigma;}model{y ~ normal(mu, sigma);}'
model_data<- list(y = rnorm(10), N = 10)
fit<-stan(model_code = model, data = model_data, iter = 4000, chains =4)
la<-extract(fit)
hist(la$mu)

## install ROpenCVLite
install.packages("ROpenCVLite")
library(ROpenCVLite) # say yes for install and creation of library

## IMPORTANT ###
# once the install is complete exit R
# go to C:\Users\Windows\Documents\R\win-library\3.6\opencv\x64\mingw\bin
# make sure this folder exist if so then go back to the 
## SET environment variables
# User variables for Windows // Path 
# and System variables // Path and add it to both envrionment
##-- C:\Users\Windows\Documents\R\win-library\3.6\opencv\x64\mingw\bin

## start cmd (right click as administrator)
## r (to start r)
## run the following command
library(ROpenCVLite)
opencvVersion() #expected outcome [1] "Version 4.5.1"
devtools::install_github("tractatus/wholebrain", args="--no-multiarch")
library(wholebrain)



##################################################################
##																##
##                              STOP HERE						##
##																##	
###################################################################





#############################################################
##/// install
#############################################################
# R # https://cloud.r-project.org/bin/windows/base/R-4.0.4-win.exe
# Rtools # https://cran.r-project.org/bin/windows/Rtools/
# https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-windows-x86_64.msi

https://cran.r-project.org/bin/windows/base/old/3.6.3/
#############################################################
##/// within R 
#############################################################

## verify good set up for path and path environment for variables
#### path 
# C:\Program Files\R\R-4.0.4\bin\x64
# C:\rtools40\usr\bin
# to verify the file on 
Sys.getenv('PATH')

##/////////// Rtools ////////////////////##
## for Rtools https://cran.r-project.org/bin/windows/Rtools/
Sys.which("make")
install.packages("jsonlite", type = "source")
##/////////// Rtools ////////////////////##


##/////////// Rstan ////////////////////##
## some warning can appear 
## verify rstan https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
install.packages("rstan", dependencies = TRUE)
## if this is not working then do 
# Compile packages using all cores
Sys.setenv(MAKEFLAGS = paste0("-j",parallel::detectCores()))
install.packages(c("StanHeaders","rstan"),type="source")

## 
library(rstan)
model<-'data{
int N;
real y[N];
}
parameters{
real mu;
real sigma;
}
model{
y ~ normal(mu, sigma);
}'

model_data<- list( y = rnorm(10), N = 10  )

fit<-stan(model_code = model, data = model_data, iter = 4000, chains =4)

la<-extract(fit)
hist(la$mu)
##/////////// Rstan ////////////////////##

##/////////// OpenCVLite ////////////////////##
# https://cran.r-project.org/web/packages/ROpenCVLite/vignettes/install.html
install.packages("ROpenCVLite")
library(ROpenCVLite)
installOpenCV()
opencvVersion() # to check if install worked
##/////////// OpenCVLite ////////////////////##

Sys.setenv(PATH = paste("C:/rtools40/mingw64/bin", Sys.getenv("PATH"), sep=";"))
Sys.setenv(BINPREF = "C:/rtools40/mingw64/bin/")  
devtools::install_github("tractatus/wholebrain", args="--no-multiarch")
devtools::install_github("tractatus/wholebrain")

# https://cran.r-project.org/web/packages/ROpenCVLite/vignettes/install.html
# install.packages("ROpenCVLite")
# library(ROpenCVLite)