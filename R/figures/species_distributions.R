# Header ----------------------------------------------------------------
# Project: KelpBiomass
# File name: species_distributions.R
# Last updated: 2024-05-28
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/KelpBiomass
# Libraries -------------------------------------------------------------
# Package for generic plotting
library(ggplot2)
# Package for adding scale bar and north arrow
library(ggspatial)
# Package for text labels
library(ggrepel)
# Package for combining plots
library(cowplot)
# Packages for getting map data
library(rnaturalearth)
library(rnaturalearthdata)

# Load data -------------------------------------------------------------
occ <- read.csv("./data/processed/species_occ.csv")

# Get polygons ----------------------------------------------------------
# Define countries for plotting
countries <- c("Ireland", "United Kingdom")

polygons <- ne_states(country = countries, returnclass = "sf")

NI <- polygons[which(polygons$region == "Northern Ireland"), ]
IE <- polygons[which(polygons$iso_a2 == "IE"), ]

shape <- rbind.data.frame(NI, IE)

# Generate map ----------------------------------------------------------
# Define colours for plotting
land <- "lightgrey"
sea <- "aliceblue"

# Make locality map
localities <- ggplot() +
  #geom_sf(colour = "black", fill = land) +
  geom_sf(data = shape, colour = "black", fill = land) +
  geom_point(data = occ, aes(x = lng, y = lat, fill = species),
             shape = 21, size = 1.25,
             colour = "black", alpha = 0.75) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  xlab("Longitude (º)") +
  ylab("Latitude (º)") +
  annotation_scale(location = "br", text_cex = 1) +
  annotation_north_arrow(location = "br",
                         pad_y = unit(0.75, "cm"),
                         height = unit(1, "cm"), width = unit(1, "cm")) +
  coord_sf(xlim = c(-10.6, -5.3), ylim = c(51.25, 55.5)) +
  facet_wrap(~species) +
  theme_bw() +
  theme(panel.background = element_rect(fill = sea),
        plot.background = element_blank(),
        legend.position = "none",
        strip.text = element_text(face = "italic"),
        axis.title = element_text(size = 16),
        axis.text = element_text(size = 12),
        panel.grid = element_blank())
localities
# Save map --------------------------------------------------------------
ggsave("./figures/species_distributions.pdf", dpi = 600,
       bg = "white",
       width = 297, height = 210, units = "mm")


