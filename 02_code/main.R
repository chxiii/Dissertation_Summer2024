#####################
# load libraries
# set wd
# clear global .envir
#####################

# remove objects
rm(list = ls())
# detach all libraries
detachAllPackages <- function() {
  basic.packages <- c("package:stats", "package:graphics", "package:grDevices", "package:utils", "package:datasets", "package:methods", "package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:", search())) == 1, TRUE, FALSE)]
  package.list <- setdiff(package.list, basic.packages)
  if (length(package.list) > 0) for (package in package.list) detach(package, character.only = TRUE)
}
detachAllPackages()

# load libraries
pkgTest <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# here is where you load any necessary packages
# ex: stringr
# lapply(c("stringr"), pkgTest)

lapply(c("readxl", "reshape2", # import data
         "zoo", "mice", # to deal with missing value
         "MetBrewer", # visualisation colour package
         "ggplot2", "ggforce", "ggthemes", "patchwork", "ggpubr", "gg.gap",
         "rnaturalearth", "rnaturalearthdata",
         "dplyr", "tidyr", 
         "ggbreak",
         "sf", "digest", "osmdata", "ggrepel", "cowplot", # for shp
         "car", # vif
         "mgcv", "ggcorrplot", "Hmisc", # GAM
         "forestplot", "broom" # forest plot
         ), pkgTest)

options(scipen = 200)

#####################
# Here is all the palette
#####################

# Les Peupliers - Monet
palette <- c("#E0D7C1", "#97B0C0", "#90A796", "#627F44")

# Wheat Field with Sheaves and a Windmill - Van Gogh
palette <- c("#EACE22", "#D9A615", "#8E6124", "#343660")

# Cloudy Wheat Field - Van Gogh
palette <- c("#CDDCDA", "#B2CCB3", "#769692", "#4C6AA8")

# The Starry Night - Van Gogh
palette <- c("#FBF1D8", "#FCE468", "#5F93DE", "#323A7E")

# Woman with a Parasol - Monet
palette <- c("#EFE5BF", "#8DACC1", "#A5AF3F", "#284020")

# - Monet
palette <- c("#C4B3C0", "#86391E", "#798A35", "#516259")

# Lottes - Monet
palette <- c("#443D6A", "#6C8EB8", "#9E7585", "#DCC39C")

# Apple tree - Monet
palette <- c("#F3EDCA", "#C8D3F9", "#A8AE5E", "#0A371C")

# Low Tide at Pourville, near Dieppe- Monet
palette <- c("#F4DF97", "#B49971", "#6C9BAC", "#196397")

# Conversation - Bato
palette <- c("#EBD1B7", "#A19DB3", "#535786", "#7A4A42")

# Stable Item - Bato
palette <- c("#EEDAE5", "#FBDD82", "#C94E2F", "#6D90ED")

# set dictionary
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

df <- read_excel("../01_data/Irish_19th_century_data.xlsx", sheet = 1)

df <- mice(df, method = 'pmm', m = 5, seed = 42)
df <- complete(df, 1)

df$grain_price_other <- df$wheat_price + df$oat_price + df$barley_price

df$grain_price_total <- df$potato_price + df$wheat_price + df$oat_price + df$barley_price

df$grain_acre_total <- df$potato_acre + df$wheat_acre + df$oat_acre + df$barley_acre

df$imports_total <- df$wheat_imports + df$barley_imports + df$oat_imports 
                   
df$exports_total <- df$wheat_exports + df$barley_exports + df$oat_exports

df$inventories <- df$exports_total - df$imports_total

summary(df)


