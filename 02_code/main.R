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

lapply(c("readxl", "ggplot2", "dplyr", "tidyr", "ggbreak"), pkgTest)

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

# set dictionary
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

df <- read_excel("../01_data/Irish_19th_century_data.xlsx", sheet = 1)



