# grain substituion

grain_substituion <- ggplot(df, aes(x = oat_price, y = potato_price)) +
  
  geom_point(color = "#4793AF", fill="white", size = 2, shape = 1) +  # Customize point color, size, and shape
  
  annotate("text", x = 12.78, y = 15.8, label = "1855") +
  annotate("text", x = 8.62, y = 23.3, label = "1846") +
  annotate("text", x = 5.1, y = 2.5, label = "1832") +
  annotate("text", x = 10, y = 18.4, label = "1847") +
  annotate("text", x = 11.16, y = 21.6, label = "1854") +
  
  labs(x = "Oat Price", y = "Potato Price", title = "Scatter Plot of Oat Price vs. Potato Price") +
  
  theme_bw() +
  
  theme(panel.grid = element_blank())

print(grain_substituion)

ggsave("../03_outputs/grain_substituion.pdf", 
       plot = grain_substituion, dpi = 300, width = 7, height = 5)

print(grain_substituion)