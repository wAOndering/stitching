# install.packages('here', repos='http://cran.us.r-project.org')
# library(here)

# TO DO:
# * have the images move around from folder to folder automatically
# * establish a strucutre of folder that enable that
# * with a static duplicate of circle to stitch

# REARRANGE FILES FOR CIRCLE PATTERN
#create template of files to fill the gap during circle stitching
# to pass the folder of interest
  # to pass arguments from the command line
  # args <- commandArgs(trailingOnly = TRUE)

  # copy the path of interest prior to running the program
  # path<-"Z:/Rumbaugh Lab/Chubbs/iPSC Project/induced Neurons (iNs)/iN Cell Lines/Cas9 Cell Lines/EGFP Lentivirus iNs/08-08-19_EGFP_Day 23 - Copy/08-08-19_0/08-08-19_0_1"
 


#careful dim in the stictch function are set up!!!
 
# for stitching ####
animal.folder<-path
defineOverlap<-0.01
animal.folder<-'C:/Users/Windows/Desktop/Jessie stitching/001_1'
animal.folder<-'C:/Users/Windows/Desktop/Jessie stitching/test - Copy'
animal.folder<-'C:/Users/Windows/Desktop/Jessie stitching/New folder'

stitch.pipeline<-function(animal.folder, channel.names = c('DAPI', 'FITC', 'dsRed')){
  #get all files in the folder
  files<-list.files(animal.folder, recursive=TRUE, full.names=TRUE)
  # if the plate is not a square for Chris on 6/7/2019 used
  #files<-grep(list.files(animal.folder, full.names=TRUE), pattern="fld ((0[1234])|([2345]1)|([3456]0)|(7[789])|80)", inv=T, value=T)
   #check only for tif images
  subset.tiff<-which(file_ext(files) == 'tif')
  files<-files[subset.tiff]
  
  #decide which folder to run in
  run.folder<-dirname(files)
  run.folder<-unique(run.folder)
  
  #allocate variables before going into the for loop
  run.image.index<-numeric()
  run.plate<-character()
  plate.col<-numeric()
  plate.row<-numeric()
  plate.order<-numeric()
  brain.sections<-numeric()
  tiles<-character()
  stitched.filename<-character()
  output.folder<-character()

  q=0;
  for(j in run.folder){
    run.image.index<-which(dirname(files)==j)
    run.plate<-files[run.image.index]

    #get row IDs
    plate.row<-substr(basename(run.plate),1,1)
    plate.row<-as.numeric(as.factor(plate.row))
    #get column ID
    plate.col<-as.numeric(substr(basename(run.plate),5,6) )
    #plate order
    plate.order<-order(plate.col, plate.row)
    run.plate<-run.plate[plate.order]
    #get unique brain section
    brain.sections<-paste(plate.col, plate.row)
    brain.sections <-lapply(1:length(unique(brain.sections)), function(x){ rep(x, sum(brain.sections==unique(brain.sections)[x]) ) })
    brain.sections <-unlist(brain.sections)
    
    #check if you have more channels
    if(!is.null(channel.names)){
      channel.ID<-character()
      for(i in channel.names){
        search.term<-paste(i,'+', sep='')
        channel.ID[grep(search.term, basename(run.plate), perl=TRUE, value=FALSE)]<-i
      }
      
    }
    
    
    for(i in unique(brain.sections)){
      
      if(is.null(channel.names)){
        tiles<-run.plate[brain.sections==i]
        stitched.filename<-paste(basename(animal.folder),'_', formatC(i+q, digits=2, flag='0'),'.tif', sep='' )
        stitched.filename<-paste(basename(animal.folder),'_', formatC(i+q, digits=2, flag='0'), '.tif', sep='' )
        cat(paste('Stitching:', stitched.filename),'\r')
        output.folder<-paste(dirname(animal.folder), paste('stitched', basename(animal.folder), sep='_'), sep='/' )
        create.output.directory(basename(output.folder),mainDir=dirname(output.folder), verbose=FALSE)
        stitch(tiles, stitched.image.name= stitched.filename, type='row.by.row', overlap = 0.1, order='right.&.down', verbose='FALSE', output.folder =output.folder)        
      }else{
        k=length(channel.names)
        while(k!=0){
          tiles<-run.plate[(brain.sections==i)&(channel.ID==channel.names[k])]
          stitched.filename<-paste(basename(animal.folder),'_', formatC(i+q, digits=2, flag='0'), '_', channel.names[k],'.tif', sep='' )
          cat(paste('Stitching:', stitched.filename),'\r')
          output.folder<-paste(dirname(animal.folder), paste('stitched', basename(animal.folder), sep='_'), sep='/' )
          create.output.directory(basename(output.folder),mainDir=dirname(output.folder), verbose=FALSE)
          stitch(tiles, stitched.image.name= stitched.filename, type='row.by.row',  overlap = defineOverlap,order='right.&.down',verbose='FALSE', output.folder =output.folder)        
          k<-k-1
        } 
      }
      
    }
    q=q+i
    
  }
}

renameFilesForStitching<-function(animal.folder){
# this function is created and use to rename the files when acquisition is done on a 8 tile image
# 4 horizontal - 2 vertical that has been acquired in the following order:
# 1 3 5 7
# 2 4 6 8
# the function is not meant to generalized acquisition pattern should be
# 1 2 3 4
# 5 6 7 8
# this will rename the files properly to run the option in the functions
oldLabel<-c('fld 2 ', 'fld 3 ', 'fld 4 ', 'fld 5 ', 'fld 6 ', 'fld 7 ')
newLabel<-c('fld 5x', 'fld 2x', 'fld 6x', 'fld 3x', 'fld 7x', 'fld 4x')

  for(i in seq_along(oldLabel)){

  files<-list.files(animal.folder, pattern=oldLabel[i], recursive=TRUE, full.names=TRUE)

    for(j in files){
      newName<-sub(oldLabel[i], newLabel[i], j)
      file.rename(j, newName)
    }
  }
}




animal.folder<-'C:/Users/Windows/Desktop/Jessie stitching/test22mod'
animal.folder<-'Y:/Jessie/e3_3histology'
renameFilesForStitching(animal.folder)
stitch.pipeline(animal.folder)


mainDir <- 'Y:/Jessie/e3_3histology'
allAnimal <- list.dirs(mainDir, recursive=FALSE)

for(i in seq_along(allAnimal)){
  print(paste(i,'/', length(allAnimal), ' - ', allAnimal[i]))
  stitch.pipeline(allAnimal[i])
}
