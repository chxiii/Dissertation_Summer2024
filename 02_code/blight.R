source("main.R")

timedf <- data.frame(
  country = c("Belgium", "France", "United Kingdom", "United Kingdom", "Ireland"),
  date = c("June 1845", "August 1845", "August 1845", "September 1845", "September 1845"),
  lon = c(3.5, 1.2, -1, -2.8, -8.2),
  lat = c(51, 49, 52, 55, 53.4)
)

# Death Rate Data
death_rate_df <- data.frame(
  country = c("Austria", "Belgium", "France", "Netherlands", "Germany", "Ireland"),
  death_rate = c(0.0036, 0.0025, 0.0024, 0.003, 0.0037, 0.12),
  unit = c("per_mille", "per_mille", "per_mille", "per_mille", "per_mille", "percent")
)

# Convert the data frames to sf objects
sf_timedf <- st_as_sf(timedf, coords = c("lon", "lat"), crs = 4326)

# Load Europe map data
world <- ne_countries(scale = "medium", returnclass = "sf")
europe <- world[world$continent == "Europe", ]

# Plotting the Blight Pathway
blight_pathway <- ggplot(data = europe) +
  geom_sf(fill = met.brewer("VanGogh2")[6]) +
  geom_sf(data = sf_timedf, aes(geometry = geometry), color = met.brewer("VanGogh2")[1], size = 2) +
  
  # Atlantic to Belgium
  annotate("curve", x = -15, y = 50.2, xend = 1.3, yend = 50.8,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = met.brewer("VanGogh2")[4], curvature = 0.25) +
  # Belgium to France
  annotate("curve", x = 3, y = 51, xend = 1.3, yend = 49.3,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = met.brewer("VanGogh2")[8], curvature = 0.3) +
  # Belgium to United Kingdom
  annotate("curve", x = 3, y = 51, xend = -0.5, yend = 52,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = met.brewer("VanGogh2")[8], curvature = 0.3) +
  # United Kingdom south to north
  annotate("curve", x = -1, y = 52.3, xend = -2.6, yend = 54.8,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = met.brewer("VanGogh2")[8], curvature = 0.3) +
  # United Kingdom south to Ireland
  annotate("curve", x = -1.5, y = 52, xend = -7.7, yend = 53.5,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = met.brewer("VanGogh2")[8], curvature = 0.3) +
  # United Kingdom north to Ireland
  annotate("curve", x = -3, y = 54.8, xend = -7.7, yend = 53.5,
           arrow = arrow(length = unit(0.3, "cm")), size = 0.5, color = met.brewer("VanGogh2")[8], curvature = -0.3) +
  
  # Add text to point
  geom_text(data = timedf, aes(x = lon, y = lat, label = date), color = "black", hjust = 1.2, size = 3) +
  
  # Add text to the arrow
  annotate("text", x = -9.8, y = 49, label = "1843 - 1845, North America", size = 3) +
  
  coord_sf(xlim = c(-15, 5), ylim = c(48, 60) , expand = FALSE) +
  labs(title = "",
       x = "",
       y = "") +
  
  theme_bw() +
  
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())

# death df
death_rate_plot <- ggplot(death_rate_df, aes(x = reorder(country, death_rate), y = death_rate)) +
  
  geom_point(size = 3, color = met.brewer("VanGogh2")[8]) +
  
  labs(title = "",
       x = "",
       y = "") +
  
  scale_y_break(c(0.004, 0.1190), space = 0.1) +
  
  scale_y_continuous(breaks = seq(-0.2, 0.2, by = 0.001)) +
  
  theme_bw() +
  
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.text.y = element_text(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major = element_line(color = met.brewer("VanGogh2")[7], linetype = "dashed")) +
  
  coord_fixed(ratio = 1)
  
death_rate_plot
  


# Combine the plots
blight_path_death <- blight_pathway + death_rate_plot + 
  
  plot_layout(ncol = 2, widths = c(1.3, 0.7))

print(blight_path_death)

ggsave("../03_outputs/blight_path_death.pdf", 
       plot = blight_path_death, dpi = 300, width = 7, height = 5)
