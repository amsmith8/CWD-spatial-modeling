#March 2021
#Learning how to extract bioClim data and clip for US 

#Run the following BEFORE uploading any package.  
#This will avoid the "ava.lang.OutOfMemoryError: Java heap space"
options(java.parameters = "-Xmx4g" )

#set directory
setwd( "/Users/lindseymixer/Documents/USF/R Files" )

#install.packages( "dismo" , "raster" , "rgdal" )
library( dismo )
library( raster )
library( rgdal )

#Get bioClim data
#This function didnt work and gave error? 
#bioClim <- raster( "wc2.1_30s_bio")  # **** You need full path or short hand syntax ( e.g., ./wc2.1_30s_bio.tif if stored in wd) - AMS 3/26/21


#View raster
#plot( bioClim )

#Create list to call files to make raster stacks 
bioClim_list <- list.files( path = "./wc2.1_30s_bio" , full.names = TRUE , pattern = ".tif" )

#Function 1 - creates stack from list of files
list_to_stack <- function( tiff.list ){
  model.stack <- stack( )
  for (i in 1:length( tiff.list ) ){
    r <- raster( tiff.list[ i ] )
    model.stack <- stack( model.stack , r ) }
  model.stack
}

#Create stacks
bioClim_stack <- list_to_stack( bioClim_list )
names( bioClim_stack ) <- c( "bio1" , "bio10" , "bio11" , "bio12" , "bio13" , "bio14" , "bio15" , "bio16" , "bio17" , "bio18" , 
                           "bio19" , "bio2" , "bio3" , "bio4" , "bio5" , "bio6 ", "bio7" , "bio8" , "bio9"  )

#Plot different bioClim variables
plot( bioClim_stack$bio1 )
plot( bioClim_stack$bio10 )

#Clipping function. Unsure how to do this step

# Import necessary shapefiles to obtain model extent

# USA
states <- rgdal::readOGR( "/Users/amsmith/Downloads/ne_110m_admin_1_states_provinces/ne_110m_admin_1_states_provinces.shp" )
cont_us <- states[states$name != "Hawaii" , ]  # remove Hawaii
#Canada
countries <- rgdal::readOGR( "/Users/amsmith/Downloads/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp" )
Canada <- countries[countries$NAME_EN =="Canada" ,  ]
# Combine
North_America <- Canada + cont_us
model_extent <- extent( North_America )

plot( North_America , main = "North America" )

# To speed up the process, we can do one of two things
# 1.) create an RDS object and import it for when we need it later
saveRDS( model_extent , file = "model_extent.rds" )

# 2.) manually write the extent you want
model_extent <- c( -171.7911 , -52.6481 , 25.07992 , 83.23324 )

# Check with a plot
plot( alt , ext = model_extent )

# We can know save this area as a new object with crop. 
study_region_alt <- crop( alt , model_extent )


# Save files 
#dir.create( "North_America_rasters" )
#writeRaster( super_stack , filename = file.path( "North_America_rasters" , names( super_stack ) ) , bylayer = TRUE , format = "GTiff" )







