# extra layers

## load contemporary WorldClim/BioClim layers
bio1_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio1.bil")
bio2_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio2.bil")
bio3_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio3.bil")
bio4_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio4.bil")
bio5_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio5.bil")
bio6_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio6.bil")
bio7_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio7.bil")
bio8_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio8.bil")
bio9_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio9.bil")
bio10_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio10.bil")
bio11_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio11.bil")
bio12_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio12.bil")
bio13_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio13.bil")
bio14_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio14.bil")
bio15_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio15.bil")
bio16_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio16.bil")
bio17_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio17.bil")
bio18_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio18.bil")
bio19_l <- raster("~/data/Bioclim/bio_2-5m_bil/bio19.bil")

## clip contemporary data layers
bio1 <- mask(bio1_l, SEstates)
#plot(bio1_l)
bio1 <- crop(bio1, extent(SEstates))
#plot(bio1)
#bio1
writeRaster(bio1, "PresentLayers/bio1.asc", format="ascii", overwrite=TRUE)

bio2 <- mask(bio2_l, SEstates)
bio2 <- crop(bio2, extent(SEstates))
writeRaster(bio2, "PresentLayers/bio2.asc", format="ascii", overwrite=TRUE)

bio3 <- mask(bio3_l, SEstates)
bio3 <- crop(bio3, extent(SEstates))
writeRaster(bio3, "PresentLayers/bio3.asc", format="ascii", overwrite=TRUE)

bio4 <- mask(bio4_l, SEstates)
bio4 <- crop(bio4, extent(SEstates))
writeRaster(bio4, "PresentLayers/bio4.asc", format="ascii", overwrite=TRUE)

bio5 <- mask(bio5_l, SEstates)
bio5 <- crop(bio5, extent(SEstates))
writeRaster(bio5, "PresentLayers/bio5.asc", format="ascii", overwrite=TRUE)

bio6 <- mask(bio6_l, SEstates)
bio6 <- crop(bio6, extent(SEstates))
writeRaster(bio6, "PresentLayers/bio6.asc", format="ascii", overwrite=TRUE)

bio7 <- mask(bio7_l, SEstates)
bio7 <- crop(bio7, extent(SEstates))
writeRaster(bio7, "PresentLayers/bio7.asc", format="ascii", overwrite=TRUE)

bio8 <- mask(bio8_l, SEstates)
bio8 <- crop(bio8, extent(SEstates))
writeRaster(bio8, "PresentLayers/bio8.asc", format="ascii", overwrite=TRUE)

bio9 <- mask(bio9_l, SEstates)
bio9 <- crop(bio9, extent(SEstates))
writeRaster(bio9, "PresentLayers/bio9.asc", format="ascii", overwrite=TRUE)

bio10 <- mask(bio10_l, SEstates)
bio10 <- crop(bio10, extent(SEstates))
writeRaster(bio10, "PresentLayers/bio10.asc", format="ascii", overwrite=TRUE)

bio11 <- mask(bio11_l, SEstates)
bio11 <- crop(bio11, extent(SEstates))
writeRaster(bio11, "PresentLayers/bio11.asc", format="ascii", overwrite=TRUE)

bio12 <- mask(bio12_l, SEstates)
bio12 <- crop(bio12, extent(SEstates))
writeRaster(bio12, "PresentLayers/bio12.asc", format="ascii", overwrite=TRUE)

bio13 <- mask(bio13_l, SEstates)
bio13 <- crop(bio13, extent(SEstates))
writeRaster(bio13, "PresentLayers/bio13.asc", format="ascii", overwrite=TRUE)

bio14 <- mask(bio14_l, SEstates)
bio14 <- crop(bio14, extent(SEstates))
writeRaster(bio14, "PresentLayers/bio14.asc", format="ascii", overwrite=TRUE)

bio15 <- mask(bio15_l, SEstates)
bio15 <- crop(bio15, extent(SEstates))
writeRaster(bio15, "PresentLayers/bio15.asc", format="ascii", overwrite=TRUE)

bio16 <- mask(bio16_l, SEstates)
bio16 <- crop(bio16, extent(SEstates))
writeRaster(bio16, "PresentLayers/bio16.asc", format="ascii", overwrite=TRUE)

bio17 <- mask(bio17_l, SEstates)
bio17 <- crop(bio17, extent(SEstates))
writeRaster(bio17, "PresentLayers/bio17.asc", format="ascii", overwrite=TRUE)

bio18 <- mask(bio18_l, SEstates)
bio18 <- crop(bio18, extent(SEstates))
writeRaster(bio18, "PresentLayers/bio18.asc", format="ascii", overwrite=TRUE)

bio19 <- mask(bio19_l, SEstates)
bio19 <- crop(bio19, extent(SEstates))
writeRaster(bio19, "PresentLayers/bio19.asc", format="ascii", overwrite=TRUE)

## load contemporary layers (if not already loaded)
bio1 <- raster("PresentLayers/bio1.asc")
bio2 <- raster("PresentLayers/bio2.asc")
bio3 <- raster("PresentLayers/bio3.asc")
bio4 <- raster("PresentLayers/bio4.asc")
bio5 <- raster("PresentLayers/bio5.asc")
bio6 <- raster("PresentLayers/bio6.asc")
bio7 <- raster("PresentLayers/bio7.asc")
bio8 <- raster("PresentLayers/bio8.asc")
bio9 <- raster("PresentLayers/bio9.asc")
bio10 <- raster("PresentLayers/bio10.asc")
bio11 <- raster("PresentLayers/bio11.asc")
bio12 <- raster("PresentLayers/bio12.asc")
bio13 <- raster("PresentLayers/bio13.asc")
bio14 <- raster("PresentLayers/bio14.asc")
bio15 <- raster("PresentLayers/bio15.asc")
bio16 <- raster("PresentLayers/bio16.asc")
bio17 <- raster("PresentLayers/bio17.asc")
bio18 <- raster("PresentLayers/bio18.asc")
bio19 <- raster("PresentLayers/bio19.asc")

## Correlation analysis for contemporary layers
stackContemp <- stack(bio1, bio2, bio3, bio4, bio5, bio6, bio7, bio8, bio9, bio10, bio11, bio12, bio13, bio14, bio15, bio16, bio17, bio18, bio19) 
corrContemp <- layerStats(stackContemp, 'pearson', na.rm=TRUE)
pearsonContemp <- corrContemp$`pearson correlation coefficient`
write.csv(pearsonContemp, "PresentLayers/correlationBioclim.csv")
