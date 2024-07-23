
# Data
data <- data.frame(
  country = c("Belgium", "France", "United Kingdom", "United Kingdom", "Ireland"),
  date = c("June 1845", "August 1845", "August 1845", "September 1845", "September 1845"),
  lon = c(3.5, 1.2, -1, -2.8, -8.2),
  lat = c(51, 49, 52, 55, 53.4)
)

# Convert the data frame to an sf object
data_sf <- st_as_sf(data, coords = c("lon", "lat"), crs = 4326)

# Load Europe map data
world <- ne_countries(scale = "medium", returnclass = "sf")
europe <- world[world$continent == "Europe", ]

# Set map range
xlim <- c(-15, 5)  # Longitude range
ylim <- c(48, 60)   # Latitude range

# Plotting
ggplot(data = europe) +
  geom_sf(fill = "#E0D7C1") +
  geom_sf(data = data_sf, aes(geometry = geometry), color = "#86391E", size = 2) +
  
  # Altanic to Belgium
  annotate("curve", x = -15, y = 50.2, xend = 1.3, yend = 50.8,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.3, color = "#D9A615", curvature = 0.25) +
  # Belgium to France
  annotate("curve", x = 3, y = 51, xend = 1.3, yend = 49.3,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = "#6C8EB8", curvature = 0.3) +
  # Belgium to United Kingdom
  annotate("curve", x = 3, y = 51, xend = -0.5, yend = 52,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = "#6C8EB8", curvature = 0.3) +
  # Uniter Kingdom south to north
  annotate("curve", x = -1, y = 52.3, xend = -2.6, yend = 54.8,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = "#6C8EB8", curvature = 0.3) +
  # United Kingdom south to Ireland
  annotate("curve", x = -1.5, y = 52, xend = -7.7, yend = 53.5,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = "#6C8EB8", curvature = 0.3) +
  # United Kingdom north to Ireland
  annotate("curve", x = -3, y = 54.8, xend = -7.7, yend = 53.5,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = "#6C8EB8", curvature = -0.3) +
  
  geom_text(data = data, aes(x = lon, y = lat, label = date), color = "black", hjust = 1.2, size = 3) +
  geom_text() +
  
  coord_sf(xlim = xlim, ylim = ylim, expand = FALSE) +
  labs(title = "Potato blight",
       x = "Longitude",
       y = "Latitude") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

