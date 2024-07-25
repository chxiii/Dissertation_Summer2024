source("main.R")


wage <- ggplot(df, aes(x = year)) +
  
  geom_rect(aes(xmin = 1845, xmax = 1851, ymin = -Inf, ymax = Inf), 
            fill = "#8DACC1", color = "black", linetype = "dotdash") +
  
  annotate("text", x = 1848, y = max(df$craftman_wage), label = "Great Famine", vjust = 20, fontface = "italic") +
  
  geom_line(aes(y = craftman_wage, linetype = "Craftman Wage"), color = "black") +
  geom_line(aes(y = general_wage, linetype = "General Wage"), color = "black") +
  
  labs(x = "Year", y = "Wage", title = "Wage") +
  
  scale_linetype_manual(name = "Type", values = c("Craftman Wage" = "solid", "General Wage" = "dashed")) +
  
  theme_bw() +
  
  theme(panel.grid = element_blank(),
        legend.position = c(0.998, 0.18), 
        legend.justification = "right",
        legend.box.just = "right")

print(wage)

ggsave("../03_outputs/wage.pdf", 
       plot = wage, dpi = 300, width = 7, height = 5)

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
