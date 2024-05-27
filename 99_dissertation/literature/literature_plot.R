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

lapply(c("sf", "ggplot2", "rnaturalearth", "rnaturalearthdata"), pkgTest)

# set wd for current folder
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# 获取世界地图数据
world <- ne_countries(scale = "medium", returnclass = "sf")

# 提取西欧国家的名称列表
west_europe_countries <- c("United Kingdom", "Germany", "France",
                           "Belgium", "Ireland")

# 过滤出西欧国家的数据
west_europe <- world[world$name %in% west_europe_countries, ]

# 提取比利时的几何数据
belgium <- world[world$name == "Belgium", ]

# 使用ggplot2绘制西欧地图，并手动填充比利时
ggplot(data = west_europe) +
  geom_sf(fill = "white", color = "black") + # 绘制西欧地图
  geom_sf(data = belgium, fill = NA, color = "black") + # 绘制比利时边界
  theme_minimal() +
  labs(title = "Map of Western Europe with Belgium Filled with Stripes")
