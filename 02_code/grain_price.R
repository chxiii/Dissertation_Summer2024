source("main.R")

price_line <- ggplot() +
  
  geom_line(data = df, aes(x = year, y = oat_price, color = "Oat"), size = .7) +
  geom_line(data = df, aes(x = year, y = potato_price, color = "Potato"), size = .7) +
  geom_line(data = df, aes(x = year, y = wheat_price, color = "Wheat"), size = .7) +
  geom_line(data = df, aes(x = year, y = barley_price, color = "Barley"), size = .7) +
  
  labs(title = "Price Trends Over Time", x = "Year", y = "Price") +
  
  scale_color_manual(
    name = "Crops",
    values = c("#EEDAE5", "#FBDD82", "#C94E2F", "#6D90ED")
  ) +
  
  theme_bw() +
  
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")
  
print(price_line)

#price_box <- ggplot() +
  
 # geom_boxplot(df, aes(x = ))