source("main.R")

pop_line <- ggplot(df, aes(x = year, y = popindex)) +
  
  geom_rect(aes(xmin = 1821, xmax = 1900, ymin = 60, ymax = 63),
            fill = NA, 
            color = met.brewer("VanGogh1")[1], linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1823, xmax = 1838, ymin = 60, ymax = 63),
            fill = met.brewer("VanGogh3")[3], 
            color = met.brewer("VanGogh1")[1], linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1838, xmax = 1869, ymin = 60, ymax = 63),
            fill = met.brewer("VanGogh3")[4], 
            color = met.brewer("VanGogh1")[1], linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1845, xmax = 1851, ymin = 60, ymax = 63), 
            fill = met.brewer("VanGogh3")[5], 
            color = met.brewer("VanGogh1")[1], linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1879, xmax = 1882, ymin = 60, ymax = 63), 
            fill = met.brewer("VanGogh3")[6], 
            color = met.brewer("VanGogh1")[1], linetype = "dotdash") +
  
  geom_line(color = met.brewer("VanGogh3")[8], size = 0.8) +
  
  geom_bar(aes(y = popgap), stat = "identity", fill = met.brewer("VanGogh3")[2], alpha = 0.6, position = "dodge") +
  
  annotate("text", x = 1830, y = 58, label = "Tithe Stage 1: 1823 - 1838", fontface = "italic", size = 2.5) +
  
  annotate("text", x = 1860, y = 65, label = "Tithe Stage 2: 1838 - 1869", fontface = "italic", size = 2.5) +
  
  annotate("text", x = 1849, y = 58, label = "Famine: 1845 - 1851", fontface = "italic", size = 2.5) +
  
  annotate("text", x = 1879, y = 58, label = "Land War: 1879 - 1882", fontface = "italic", size = 2.5) +
  
  geom_rect(aes(xmin = 1823, xmax = 1823, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1838, xmax = 1838, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1845, xmax = 1845, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1851, xmax = 1851, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1869, xmax = 1869, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1879, xmax = 1879, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1882, xmax = 1882, ymin = 60, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  geom_rect(aes(xmin = 1823, xmax = 1882, ymin = 125, ymax = 125),
            fill = NA, 
            color = "grey", linetype = "dotdash") +
  
  theme_bw() +
  
  labs(title = "Population Index and Events, 1840 = 100") +
  
  scale_x_continuous(breaks = seq(1820, 1900, by = 10)) +
  
  scale_y_continuous(breaks = seq(55, 125, by = 5)) +
  
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

pop_line

pop_line <- pop_line + scale_y_break(c(3, 55), space = 0.2) +

print(pop_line)

ggsave("../03_outputs/popline.pdf", 
       plot = pop_line, dpi = 300, width = 7, height = 5)

