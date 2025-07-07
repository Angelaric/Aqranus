# All the library we need

library(sf)
library(dplyr)
library(sfnetworks)
library(movecost)
library(terra)
library(leastcostpath)
library(here)
library(mapview)

# Load Data

######################  VECTORS

# Create the locations Lufisa, Farui and Istibuni

Locations <- data.frame(place = c("Lufisa", 
                                  "Farui",
                                  "Istibuni"),
                        longitude=c(24.715602,  # 1 Lufisa
                                    25.626568,  # 2 Farui
                                    23.816906), # 3 Istibuni
                        
                        
                        latitude=c(43.127531,  # 1 Lufisa
                                   42.426359,  # 2 Farui
                                   42.439499   # 3 Istibuni
                                   
                        ))%>%
  st_as_sf(coords = c("longitude", "latitude"), crs=4326)%>% # Convert the data frame to an sf object             
  
  st_transform(crs = 32635) # Transform the points to CRS EPSG 32635



# This is the road system with all Wendel's (2005) categories as shapefiles. 
# It is georeferenced and digitised by us.

WendelRoads <- st_read(here("data", "WendelRoads2.shp"))

# Because of the specifications of sfnetwork package we need to: 
# Here follows the loading of the Wendel's road system converted from lines to points.
# The file is created in QGIS with Convert Lines to Polygons. 
# In field "Lines" the vectorised Wendel's roads file is loaded. 
# Then check the field "Insert Additional Points". 
# Insert "Distance = 500 m". Check "Add Point Order".
# In this way we have converted the shapefile from line to points with point in every 500 m. 
# Then leave only the fields "FID", "Shape", "Type", "Shape Lenght" and "PT ID". 
# We will need them. 

WendelRoadsPoints <- st_read(here("data", "WendelRoads2Points.shp"))


# Create dataframe with lat long data for Beroe, Tarnovo and Tsareva Livada 
# These destinations/origins are used in the additional LCP and Shortest Road Network Analysis.

Origo_Destino <- data.frame(place = c("Beroe", 
                                      "Tarnovo",
                                      "Tsareva Livada"),
                            longitude=c(25.630772, 25.652008, 25.442040),
                            latitude=c(42.428833, 43.083266, 42.953527))%>%
  st_as_sf(coords = c("longitude", "latitude"), crs=4326)%>% # Convert the data frame to an sf object             
  
  st_transform(crs = 32635) # Transform the points to CRS EPSG 25832


# Because the claim is that the Romans and after the Roman Period the roads were following the ridges of the mountains, 
# so this is the file with the extracted ridges, which will force the model to use them instead of the valleys. 
# The Dataset is created in r.geomorphon in GRAS GISS as follows: 
# For this purpose we create a new file in r.geomorphon elevation="here we load our DEM" forms="BalcFormsR10Scip05Flat5" search=10 skip=5 flat=5 dist=0 step=0 start=0
# From this file in GRAS GIS with r.pamcalc we will cut only the ridges and peaks. The formula is as follows r.mapcalc expression ”Ridges= if((BalcFormsR10Scip05Flat5 >= 2 && BalcFormsR10Scip05Flat5 <= 3), 1, null())”, 
# where 2 is the code for the peak, and 3 for the ridge. You get code 1, and everything else with code 0. Export this file to geotiff.
# Then we make the geotiff. into vectors with r.to.vect (r.to.vect input=Ridges@CFMN output=RidgesVector@CFMN type=area) and export them as a shapefile SR2.shp

Ridges <- st_read("data/SR2.shp") %>%
  as_Spatial()


##############  RASTERS

# Create a DEM of Territory and Territory2 using `geodata` library

# [AS] If I know your DEM resolution and extent, I may be able to replicate it.
# Load rasters
library(geodata)

# Whole of BG at 30s resolution
dem <- elevation_30s(country = "BG", path = ".", mask = TRUE)
plot(dem)

# Territory specified by lat/long at 3s resolution, may need mosaicing
hires_dem <- elevation_3s(lon = 23.383056, lat = 42.666944, path = ".")

# [AS]: if you provide extent, I will generate Territory2 in a reproducible way
# now I am extrapolating extent from your Locations
extent <- Origo_Destino %>% 
  st_buffer(15000) %>% 
  st_union() %>% 
  st_convex_hull() %>% 
  st_make_grid( n =1) %>% 
  st_sf() 
  
mapview(extent)


Territory2 <- dem %>% 
  crop(st_transform(extent, 4326)) %>% 
  project("EPSG:32635")

Territory <- dem %>% project("EPSG:32635")


# View results

mapview(aggregate(Territory, 10)) + mapview(extent) + mapview(Locations)

mapview(Territory2) + mapview(Origo_Destino)
