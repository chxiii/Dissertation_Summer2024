source("main.R")


shp <- st_read("../01_data/Shapefiles/Ireland_counties.shp")

pop <- read_excel("../01_data/Irish_census_1841-1851.xlsx")

shp <- shp %>% left_join(pop, by = "NAME")

shp <- shp %>%
  mutate(
    POP1841 = cut(POP1841, breaks = c(0, 100000, 200000, 300000, 400000, 
                                      500000, 600000, 700000, Inf), 
                  labels = c("0-100k", "100k-200k", "200k-300k", "300k-400k", 
                             "400k-500k", "500k-600k", "600k-700k", "700k-800k")),
    POP1851 = cut(POP1851, breaks = c(0, 100000, 200000, 300000, 400000, 
                                      500000, 600000, 700000, Inf),  
                  labels = c("0-100k", "100k-200k", "200k-300k", "300k-400k", 
                             "400k-500k", "500k-600k", "600k-700k", "700k-800k"))
  )

# 打印分类后的数据，检查是否包含所有类别
print(table(shp$POP1841))
print(table(shp$POP1851))

shp <- shp %>%
  bind_rows(data.frame(
    NAME = "Dummy",
    POP1841 = factor(c("500k-600k", "600k-700k"), 
                     levels = c("0-100k", "100k-200k", "200k-300k", "300k-400k", 
                                "400k-500k", "500k-600k", "600k-700k", "700k-800k")),
    POP1851 = factor(c("600k-700k", "700k-800k"), 
                     levels = c("0-100k", "100k-200k", "200k-300k", "300k-400k", 
                                "400k-500k", "500k-600k", "600k-700k", "700k-800k"))
  ))

# colour
custom_colors <- met.brewer("VanGogh3", 8)

# 1841 heat map
map_1841 <- ggplot(shp) +
  geom_sf(aes(fill = factor(POP1841))) +
  scale_fill_manual(values = custom_colors, name = "Population", drop = FALSE) +
  theme_bw() +
  theme(legend.position = "bottom",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("1841 County Population")

# 1851 heat map
map_1851 <- ggplot(shp) +
  geom_sf(aes(fill = factor(POP1851))) +
  scale_fill_manual(values = custom_colors, name = "Population", drop = FALSE) +
  theme_bw() +
  theme(legend.position = "bottom", 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("1851 County Population")

# combine two maps
popmap1841_1851 <- ggarrange(map_1841, map_1851, nrow = 1, 
                             common.legend = TRUE,
                             legend = "bottom")

#popmap1841_1851 <- map_1841 + map_1851 + 
#  plot_layout(guides = "collect") & theme(legend.position = "bottom")

print(popmap1841_1851)

ggsave("../03_outputs/map1841_1851.pdf", 
       plot = popmap1841_1851, dpi = 300, width=7, height=5)
