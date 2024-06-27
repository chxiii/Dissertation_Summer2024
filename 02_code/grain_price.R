source("main.R")

ggplot() +
  geom_line(data = df, aes(x = year, y = oat_price, color = "Oat Price")) +
  geom_line(data = df, aes(x = year, y = potato_price, color = "Potato Price")) +
  geom_line(data = df, aes(x = year, y = wheat_price, color = "Wheat Price")) +
  geom_line(data = df, aes(x = year, y = barley_price, color = "Barley Price")) +
  labs(title = "Price Trends Over Time", x = "Year", y = "Price") +
  scale_color_manual(
    name = "Variable",
    #values = c("Oat Price" = "#C4B3C0", "Potato Price" = "#86391E", 
    #           "Wheat Price" = "#798A35", "Barley Price" = "#516259") +
    values = c("#C4B3C0", "#86391E", "#798A35", "#516259")
  ) +
  theme_bw()