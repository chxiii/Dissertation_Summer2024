# grain substituion

grain_substituion <- ggplot(df, aes(x = oat_price, y = potato_price)) +
  
  geom_point(color = met.brewer("VanGogh1")[2], fill="white", size = 2, shape = 1) +  # Customize point color, size, and shape
  
  annotate("text", x = 5.1, y = 2.5, label = "1832") +
  
  annotate("text", x = 7.13, y = 6.86, label = "1845") +
  annotate("text", x = 8.62, y = 23.3, label = "1846") +
  annotate("text", x = 10, y = 18.4, label = "1847") +
  annotate("text", x = 6.43, y = 21.04, label = "1848") +
  annotate("text", x = 5.89, y = 15.75, label = "1849") +
  annotate("text", x = 7.09, y = 16.03, label = "1850") +
  annotate("text", x = 6.89, y = 12.95, label = "1851") +
  
  annotate("text", x = 12.78, y = 15.8, label = "1855") +
  
  annotate("curve", x = 7.13, y = 6.16, xend = 8.62, yend = 22.61,
           arrow = arrow(length = unit(0.3, "cm")), 
           size = 0.75, color = met.brewer("VanGogh1")[4], curvature = 0) + 
  
  annotate("curve", x = 8.62, y = 22.61, xend = 9.98, yend = 17.78,
           arrow = arrow(length = unit(0.3, "cm")), 
           size = 0.75, color = met.brewer("VanGogh1")[4], curvature = 0) + 
  
  annotate("curve", x = 9.98, y = 17.78, xend = 6.43, yend = 20.44,
           arrow = arrow(length = unit(0.3, "cm")), 
           size = 0.75, color = met.brewer("VanGogh1")[4], curvature = 0) + 
  
  annotate("curve", x = 6.43, y = 20.44, xend = 5.88, yend = 15.05,
           arrow = arrow(length = unit(0.3, "cm")), 
           size = 0.75, color = met.brewer("VanGogh1")[4], curvature = 0) + 
  
  annotate("curve", x = 5.88, y = 15.05, xend = 7.08, yend = 15.33,
           arrow = arrow(length = unit(0.3, "cm")), 
           size = 0.75, color = met.brewer("VanGogh1")[4], curvature = 0) + 
  
  annotate("curve", x = 7.08, y = 15.35, xend = 6.88, yend = 12.25,
           arrow = arrow(length = unit(0.3, "cm")), 
           size = 0.75, color = met.brewer("VanGogh1")[3], curvature = 0) + 
  
  labs(x = "Oat Price", y = "Potato Price", title = "Oat Price & Potato Price with Famine Price Trend") +
  
  theme_bw() +
  
  theme(panel.grid = element_blank())

print(grain_substituion)

  ggsave("../03_outputs/grain_substituion.pdf", 
       plot = grain_substituion, dpi = 300, width = 7, height = 5)

