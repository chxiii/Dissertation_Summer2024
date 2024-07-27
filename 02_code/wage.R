source("main.R")


wage <- ggplot(df, aes(x = year)) +
  
  geom_rect(aes(xmin = 1845, xmax = 1851, ymin = -Inf, ymax = Inf), 
            fill = met.brewer("Monet")[3], color = "black", linetype = "dotdash") +
  
  annotate("text", x = 1848, y = max(df$craftman_wage), label = "Great Famine", vjust = 20, fontface = "italic") +
  
  geom_line(aes(y = craftman_wage, linetype = "Craftman Wage"), color = met.brewer("Monet")[6], linewidth = 0.8) +
  geom_line(aes(y = general_wage, linetype = "General Wage"), color = met.brewer("Monet")[7], linewidth = 0.8) +
  
  labs(x = "Year", y = "Wage", title = "Wage") +
  
  scale_linetype_manual(name = "Type", values = c("Craftman Wage" = "solid", "General Wage" = "solid")) +
  
  theme_bw() +
  
  theme(panel.grid = element_blank(),
        legend.position = c(0.998, 0.18), 
        legend.justification = "right",
        legend.box.just = "right")

print(wage)

ggsave("../03_outputs/wage.pdf", 
       plot = wage, dpi = 300, width = 7, height = 5)


