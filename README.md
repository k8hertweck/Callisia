# Callisia

Scripts for creating maps and performing niche modeling using R.

The general workflow is as follows:

* `callisiaMapping.R`: importing taxon occurrence data into R, creating maps, creating custom shapefiles
* `callisiaLayerPrep.R`: masking/clipping PRISM layers, looking for correlations between layers
* `callisiaNicheModeling.R`: creating niche models using occurrence data and climate layers
* `callisiaNicheOverlap.R`: assessing whether niche models for different taxa are distinct from each other
* `extraLayers.R`: assesses BioClim correlations
* `layerAverage.R`: averaging PRISM layers across 10 year intervals

There are a number of files and directories that are downloaded or created during this analysis. To perform all commands in `layerPrep.R`, you should download the BioClim layers and store them in a convenient place (note the paths for using these layers may need to be changed). Clipped layers are included in `PastLayers/` and `PresenceLayers` for your convenience.
