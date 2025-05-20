# All the library we need

library(sf)
library(dplyr)
library(sfnetworks)
library(raster)
library(movecost)
library(sp)
library(terra)
library(leastcostpath)
library(here)
library(mapview)

# Load Data
setwd("Z:/CAA2025/()!_Krunos_horos/!R/AqranusGitHub") # I am not sure it will work... 

# The DEM of Bulgaria which we will need. Because it is too heavy to be uploaded in GitHub,
# I load it from my computer, but it can be downloaded from... (I don't know. May be you can point to it)

Territory <- raster("Z:/CAA2025/()!_Krunos_horos/Balc_DEM.tif")


# Create the locations Lufisa, Farui and Istibuni

Locations <- data.frame(place = c("Lufisa", 
                                  "Farui",
                                  "Istibuni"),
                        longitude=c(24.715602, # 1 Lufisa
                                    25.626568, # 2 Farui
                                    23.816906), # 3 Istibuni
                        
                        
                        latitude=c(43.127531,  # 1 Lufisa
                                   42.426359,  # 2 Farui
                                   42.439499   # 3 Istibuni
                                   
                        ))%>%
  st_as_sf(coords = c("longitude", "latitude"), crs=4326)%>% # Convert the data frame to an sf object             
  
  st_transform(crs = 32635) # Transform the points to CRS EPSG 32635

# This is the road system with all Wendel's (2005) categories as shapefiles. 
# It is georeferenced and digitised by me.

WendelRoads <- st_read(here("data", "WendelRoads2.shp"))

# Here follows the loading of the Wendel's road system converted from lines to points.
# The file is created in QGIS with Convert Lines to Polygons. 
# In field "Lines" the vectorised Wendel's roads file is loaded. 
# Then check the field "Insert Additional Points". 
# Insert "Distance = 500 m". Check "Add Point Order".
# In this way we have converted the shapefile from line to points with point in every 500 m. 
# Then leave only the fields "FID", "Shape", "Type", "Shape Lenght" and "PT ID". 
# We will need them. 

WendelRoadsPoints <- st_read(here("data", "WendelRoads2Points.shp"))


# Create dataframe with lat long data for Beroe, Tarnovo and Strinava
Origo_Destino <- data.frame(place = c("Beroe", 
                                      "Tarnovo",
                                      "Strinava"),
                            longitude=c(25.630772, 25.652008, 25.442040),
                            latitude=c(42.428833, 43.083266, 42.953527))%>%
  st_as_sf(coords = c("longitude", "latitude"), crs=4326)%>% # Convert the data frame to an sf object             
  
  st_transform(crs = 32635) # Transform the points to CRS EPSG 25832


# Because the claim is that the Romans and after the Roman Period the roads were following the ridges of the mountains, 
# so this is the file with the extracted ridges, which will force the model to use them instead of the valleys

Ridges <- st_read("data/SR2.shp") %>%
  as_Spatial()


# This is the DEM we need for the LCP Analysis. It includes river Thundza as a barrier and the fords for crossing the river.
# But this file is too big for GitHub and I will ignore it. I don't know any other way how to share it. It is just a DEM. 
# You said that you can use some internet generated. 
# A simple DEM for the region is enough too. It is not necessary to have the River as a barrier.
Territory2 <- raster("data/large/CityTerTonsosBarr.tif") 
