source("main.R")

price_line <- ggplot() +
  
  geom_line(data = df, aes(x = year, y = oat_price, color = "Oat"), size = .5) +
  geom_line(data = df, aes(x = year, y = potato_price, color = "Potato"), size = .5) +
  geom_line(data = df, aes(x = year, y = wheat_price, color = "Wheat"), size = .5) +
  geom_line(data = df, aes(x = year, y = barley_price, color = "Barley"), size = .5) +
  
  labs(title = "Price Trends Over Time", x = "Year", y = "Price") +
  
  scale_color_manual(
    name = "Crops",
    values = c("#C4B3C0", "#86391E", "#798A35", "#516259")
  ) +
  
  scale_x_continuous(breaks = seq(1820, 1900, by = 5)) +
  
  theme_bw() +
  
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")

price_line <- price_line + facet_zoom(xlim = c(1845, 1851), 
                                      y = TRUE, zoom.size = 0.25, 
                                      split = FALSE, horizontal = TRUE) +
  
  theme(zoom.y = element_rect(fill = NA, color = NA))

print(price_line)

ggsave("../03_outputs/grain_price.pdf", 
       plot = price_line, dpi = 300, width=7, height=5)
  
 # geom_boxplot(df, aes(x = ))