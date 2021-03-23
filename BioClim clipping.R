#March 2021
#Learning how to extract bioClim data and clip for US 

#Run the following BEFORE uploading any package.  
#This will avoid the "ava.lang.OutOfMemoryError: Java heap space"
options(java.parameters = "-Xmx4g" )

#set directory
setwd("/Users/lindseymixer/Documents/USF/R Files")

#install.packages("dismo", "raster", "rgdal")
library(dismo)
library(raster)
library(rgdal)

#Get bioClim data
#This function didnt work and gave error? 
#bioClim <- raster("wc2.1_30s_bio")

#View raster
#plot(bioClim)

#Create list to call files to make raster stacks 
bioClim_list <- list.files(path = "./wc2.1_30s_bio",full.names= TRUE, pattern = ".tif")

#Function 1 - creates stack from list of files
list_to_stack <- function(tiff.list){
  model.stack <- stack()
  for (i in 1:length(tiff.list)){
    r <- raster(tiff.list[i])
    model.stack <- stack(model.stack, r)}
  model.stack
}

#Create stacks
bioClim_stack <- list_to_stack(bioClim_list)
names(bioClim_stack) <- c( "bio1" , "bio10" , "bio11" , "bio12" , "bio13" , "bio14" , "bio15" , "bio16" , "bio17" , "bio18" , 
                           "bio19" , "bio2" , "bio3" , "bio4" , "bio5" , "bio6 ", "bio7" , "bio8" , "bio9"  )

#Plot different bioClim variables
plot(bioClim_stack$bio1)
plot(bioClim_stack$bio10)

#Clipping function. Unsure how to do this step
mask(x,y) 












