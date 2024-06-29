source("main.R")

price_line <- ggplot() +
  
  geom_line(data = df, aes(x = year, y = oat_price, color = "Oat", linetype = "Oat"), size = .5) +
  geom_line(data = df, aes(x = year, y = potato_price, color = "Potato", linetype = "Potato"), size = .55) +
  geom_line(data = df, aes(x = year, y = wheat_price, color = "Wheat", linetype = "Wheat"), size = .5) +
  geom_line(data = df, aes(x = year, y = barley_price, color = "Barley", linetype = "Barley"), size = .5) +
  
  annotate("text", x = 1849, y = 24, label = "Great Famine: 1845 - 1851", fontface = "italic", size = 3) +
  
  labs(title = "Grain Price with Potato and Oat Price cross Famine", x = NULL, y = "Grain Price") +
  
  scale_color_manual(
    name = "Crops",
    values = c("#A8AE5E", "#6C8EB8", "#9E7585", "#DCC39C")
  ) +
  
  scale_linetype_manual(
    name = "Crops",
    values = c("twodash", "dotdash", "longdash", "solid")
  ) +
  
  scale_x_continuous(breaks = seq(1820, 1900, by = 5)) +
  
  theme_bw() +
  
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")

price_line <- price_line + facet_zoom(xlim = c(1844, 1852), 
                                      ylim = c(5, 22), zoom.size = 0.25, 
                                      split = FALSE, horizontal = TRUE) +
  
  theme(zoom.y = element_rect(fill = NA, color = "grey", linewidth = 0.3),
        zoom.x = element_rect(fill = "grey", color = "grey", linewidth = 0.3))

print(price_line)

ggsave("../03_outputs/grain_price.pdf", 
       plot = price_line, dpi = 300, width=7, height=5)
  
