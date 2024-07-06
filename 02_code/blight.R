source("main.R")

# 获取西欧地区的地图数据
world <- ne_countries(scale = "medium", returnclass = "sf")
europe <- subset(world, continent == "Europe")

# 定义西欧国家
western_europe_countries <- c("Ireland", "United Kingdom")
western_europe <- subset(europe, sovereignt %in% western_europe_countries)

# 创建模拟的马铃薯晚疫病到达时间数据
set.seed(123)
points <- st_sample(western_europe, size = 50, type = "random")
times <- sample(1845:1850, size = 50, replace = TRUE)
data <- data.frame(st_coordinates(points), time = times)

# 绘制地图和等高线
ggplot() +
  geom_sf(data = western_europe, fill = "white", color = "black") +
  geom_point(data = data, aes(X, Y, color = factor(time)), size = 2) +
  stat_density2d(data = data, aes(X, Y, fill = ..level..), geom = "polygon", alpha = 0.3) +
  scale_fill_viridis_c(option = "C") +
  labs(title = "Spread of Potato Blight in Western Europe (1845-1850)",
       x = "Longitude", y = "Latitude", fill = "Density", color = "Arrival Year") +
  theme_bw()
