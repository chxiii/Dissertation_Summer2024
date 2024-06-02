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

lapply(c("sf", "ggplot2", "rnaturalearth", "rnaturalearthdata", "dplyr"), pkgTest)

# set wd for current folder
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# 获取世界地图数据
world <- ne_countries(scale = "medium", returnclass = "sf")

# 提取爱尔兰的地理数据
ireland <- world %>% filter(name == "Ireland")

# 示例人口数据（你需要用真实数据替换）
population_data <- data.frame(
  county = c("Dublin", "Wicklow", "Killdare"), # 替换为真实的郡名
  population = c(100000, 200000, 150000)      # 替换为真实的人口数据
)

# 合并地理数据和人口数据
ireland_data <- left_join(ireland, population_data, by = c("name" = "county"))

# 绘制地图并根据人口上色
ggplot(data = ireland_data) +
  geom_sf(aes(fill = population)) + # 根据人口填充颜色
  scale_fill_viridis_c(option = "viridis", na.value = "white") + # 使用Viridis色标
  theme_minimal() +
  labs(title = "Population by County in Ireland", fill = "Population")