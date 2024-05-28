# Header ----------------------------------------------------------------
# Project: KelpBiomass
# File name: 01_data_prep.R
# Last updated: 2024-05-28
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/KelpBiomass

# Load libraries --------------------------------------------------------


# Occurrence data -------------------------------------------------------

sp1 <- read.csv("./data/raw/Alaria.csv")
sp2 <- read.csv("./data/raw/Laminaria digitata.csv")
sp3 <- read.csv("./data/raw/Laminaria hyperborea.csv")
sp4 <- read.csv("./data/raw/Laminaria ochroluca.csv")
sp5 <- read.csv("./data/raw/Saccharina latissima.csv")
sp6 <- read.csv("./data/raw/Saccorhiza polyschides.csv")
# Bind data
occ <- rbind.data.frame(sp1, sp2, sp3, sp4, sp5, sp6)
# Subset to data of interest
occ <- data.frame(species = occ$Species, 
                  lng = occ$longitude, 
                  lat = occ$latitude)
write.csv(occ, "./data/processed/species_occ.csv", row.names = FALSE)
