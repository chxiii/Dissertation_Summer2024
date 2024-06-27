source("main.R")

ggplot() +
  
  geom_line(data = df, aes(x = year, y = oat_price, color = "Oat Price")) +
  geom_line(data = df, aes(x = year, y = potato_price, color = "Potato Price")) +
  geom_line(data = df, aes(x = year, y = wheat_price, color = "Wheat Price")) +
  geom_line(data = df, aes(x = year, y = barley_price, color = "Barley Price")) +
  
  labs(title = "Price Trends Over Time", x = "Year", y = "Price") +
  
  scale_color_manual(
    name = "Variable",
    values = c("#F4DF97", "#B49971", "#6C9BAC", "#196397")
  ) +
  
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom") +
  
  theme_bw()