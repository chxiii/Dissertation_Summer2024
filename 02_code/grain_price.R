source("main.R")

price_line <- ggplot() +
  
  geom_line(data = df, aes(x = year, y = oat_price, color = "Oat")) +
  geom_line(data = df, aes(x = year, y = potato_price, color = "Potato")) +
  geom_line(data = df, aes(x = year, y = wheat_price, color = "Wheat")) +
  geom_line(data = df, aes(x = year, y = barley_price, color = "Barley")) +
  
  labs(title = "Price Trends Over Time", x = "Year", y = "Price") +
  
  scale_color_manual(
    name = "Crops",
    values = c("#EBD1B7", "#A19DB3", "#535786", "#7A4A42")
  ) +
  
  theme_bw() +
  
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")
  
print(price_line)

#price_box <- ggplot() +
  
 # geom_boxplot(df, aes(x = ))