source("main.R")

shp <- st_read("../01_data/province_boundaries/Province_Boundaries_Ungeneralised_-_National_Administrative_Boundaries_-_2015.shp")
pop <- read_excel("../01_data/Irish_census_1841-1851.xlsx")

shp <- shp %>% left_join(pop, by = "PROVINCE")


print(shp)
#ggplot(shp) +
#  geom_sf() +
#  theme_bw()