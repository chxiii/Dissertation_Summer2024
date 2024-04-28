
library(ggplot2)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

data <- data.frame(
  Year = c(1821:1900),
  pop_thou = c(
    6802, 6893, 6985, 7078, 7173, 7269, 7366, 7464, 7564, 7662,
    7767, 7810, 7852, 7954, 7938, 7981, 8024, 8068, 8111, 8156,
    8175, 8221, 8240, 8277, 8295, 8288, 8025, 7640, 7256, 6878,
    6552, 6337, 6199, 6083, 6015, 5973, 5919, 5891, 5862, 5821,
    5788, 5776, 5718, 5641, 5595, 5523, 5487, 5466, 5449, 5419,
    5398, 5373, 5328, 5299, 5279, 5278, 5286, 5282, 5266, 5203,
    5146, 5101, 5024, 4975, 4939, 4906, 4857, 4801, 4757, 4718,
    4681, 4634, 4607, 4589, 4560, 4542, 4530, 4518, 4502, 4469
  ),
  craftman_wage = c(26, 26, 26, 26, 26, 24, 26, 26, 26, 26, 26, 26, 26, 26, 26, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 25, 25, 25, 25, 25, 25, 25, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 24, 24, 24, 24, 26, 26, 26, 26, 28, 28, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 42, 42, 42, 42, 42, 42, 36, 36, 36, 36, 36),
  general_wage = c(18, 20, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 21, 24, 24, 24, 24, 24, 26, 26, 26, 26, 27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 32, 30, 30, 34, 36, 34, 40, 40, 40, 40),
  oat_price <- c(6.249, 5.845, 6.47, 7.837, 7.776, 7.974, 8.001, 6.467, 6.738, 7.702, 7.312, 5.421, 5.113, 5.762, 6.435, 7.176, 6.805, 6.751, 8.427, 7.729, 6.697, 6.023, 5.212, 6.3, 7.137, 8.621, 9.986, 6.437, 5.889, 7.087, 6.889, 7.499, 9.354, 11.162, 12.781, 8.688, 8.363, 7.729, 8.987, 10.719, 8.688, 7.729, 7.729, 7.115, 9.283, 10.127, 12.676, 10.719, 10.512, 9.831, 10.008, 9.51, 8.41, 11.162, 10.16, 9.185, 10.008, 10.512, 10.59, 9.283, 9.831, 9.635, 9.712, 8.987, 11.3, 7.651, 7.573, 8.24, 8.815, 9.51, 10.433, 10.433, 10.16, 8.936, 7.499, 7.807, 8.163, 8.085, 8.085, 8.363),
  potato_price <- c(4.88, 6.8, 3.85, 7.7, 5.3, 7.7, 8.48, 4.06, 4.92, 6.93, 7.08, 3.84, 3.2, 6.44, 3.58, 5.44, 7.9, 5.89, 7.3, 7, 6.33, 7.97, 4.51, 5.54, 6.16, 22.61, 17.78, 20.44, 15.05, 15.33, 12.25, 13.93, 15.61, 21, 15.05, 10.5, 17.78, 10.22, 12.39, 18.55, 15.89, 12.67, 8.89, 9.17, 10.22, 12.11, 14, 12.39, 10.78, 12.95, 13.72, 21.84, 15.61, 9.94, 11.34, 11.41, 19.39, 14.56, 19.95, 9.94, 7.56, 7.56, 7.56, 8.19, 7, 5.67, 7.35, 5.95, 5.25, 5.74, 9.73, 11.9, 10.43, 8.61, 7.14, 7.63, 7.77, 6.37, 6.86, 9.03),
  wheat_price <- c(2.76, 2.92, 2.63, 3.01, 2.72, 2.82, 2.7, 2.69, 3.21, 3.20, 3.30, 2.94, 2.61, 2.26, 1.97, 2.41, 2.76, 3.25, 3.53, 3.34, 3.25, 2.84, 2.52, 2.51, 2.51, 3.35, 2.51, 2.23, 1.69, 1.87, 1.69, 1.95, 3.17, 3.12, 3.84, 2.61, 2.20, 1.77, 2.20, 2.53, 2.43, 1.87, 1.77, 1.64, 2.59, 2.74, 3.20, 3.00, 2.51, 2.15, 2.61, 2.64, 2.51, 1.95, 1.97, 2.02, 2.28, 1.84, 2.30, 1.95, 2.12, 1.95, 1.79, 1.59, 1.48, 1.36, 1.41, 1.56, 1.46, 1.51, 1.66, 1.51, 1.36, 1.28, 1.28, 1.43, 1.64, 1.43, 1.38, 1.43),
  barley_price <- c(1.23, 1.29, 1.38, 1.24, 1.21, 1.34, 1.42, 1.33, 1.31, 1.33, 1.60, 1.29, 1.12, 1.17, 1.21, 1.32, 1.28, 1.26, 1.61, 1.45, 1.29, 1.12, 1.18, 1.32, 1.56, 2.31, 1.53, 1.32, 1.12, 1.15, 1.12, 1.28, 1.78, 1.70, 2.36, 1.97, 1.68, 1.35, 1.58, 1.78, 1.53, 1.44, 1.37, 1.35, 1.52, 2.06, 1.97, 2.05, 1.95, 1.56, 1.70, 1.76, 1.06, 1.74, 1.66, 1.61, 1.73, 1.61, 1.56, 1.50, 1.49, 1.52, 1.47, 1.40, 1.32, 1.08, 1.20, 1.32, 1.32, 1.31, 1.48, 1.41, 1.36, 1.41, 1.36, 1.28, 1.29, 1.43, 1.33, 1.39),
  wheat_yield <- c(156, 165, 149, 171, 154, 160, 153, 152, 182, 181, 187, 167, 148, 128, 112, 137, 156, 184, 200, 189,
                   184, 161, 143, 142, 142, 190, 272, 245, 243, 213, 173, 125, 113, 143, 155, 181, 192, 185, 157,
                   157, 133, 118, 87, 96, 93, 102, 88, 93, 87, 80, 74, 66, 50, 57, 47, 35, 42, 48, 48, 45, 47, 46,
                   27, 19, 20, 19, 18, 29, 28, 28, 24, 22, 16, 14, 10, 11, 13, 15, 15, 15)
  )

pdf("population.pdf", width=6.27, height=3.54)
ggplot(data, aes(x = Year, y = pop_thou)) +
  
  geom_rect(aes(xmin = 1845, xmax = 1851, ymin = -Inf, ymax = Inf), 
            fill = "#E4745E", color = "black", linetype = "dotdash") +
  annotate("text", x = 1848, y = max(data$pop_thou), label = "Great Famine", vjust = 21, fontface = "italic") +
  geom_rect(aes(xmin = 1877, xmax = 1879, ymin = -Inf, ymax = Inf), 
            fill = "#FED59E", color = "black", linetype = "dotdash") +
  annotate("text", x = 1878, y = max(data$pop_thou), label = "Land War", vjust = 21, fontface = "italic") +
  geom_rect(aes(xmin = 1838, xmax = 1838, ymin = -Inf, ymax = Inf), 
            fill = NA, color = "black", linetype = "dotdash") +
  annotate("text", x = 1838, y = max(data$pop_thou), label = "Poor Law", vjust = 13, fontface = "italic") +
  
  geom_line() +
  
  labs(x = "Year", y = "Population (thousands)", title = "Population Over Time") +
  
  scale_x_continuous(breaks = seq(1820, 1900, by = 10)) +
  theme_bw() +
  theme(panel.grid = element_blank())

dev.off()

pdf("wage.pdf", width=6.27, height=3.54)
ggplot(data, aes(x = Year)) +
  
  geom_rect(aes(xmin = 1845, xmax = 1851, ymin = -Inf, ymax = Inf), 
            fill = "#E4745E", color = "black", linetype = "dotdash") +
  annotate("text", x = 1848, y = max(data$craftman_wage), label = "Great Famine", vjust = 20, fontface = "italic") +
  geom_rect(aes(xmin = 1877, xmax = 1879, ymin = -Inf, ymax = Inf), 
            fill = "#FED59E", color = "black", linetype = "dotdash") +
  annotate("text", x = 1878, y = max(data$craftman_wage), label = "Land War", vjust = 20, fontface = "italic") +
  geom_rect(aes(xmin = 1838, xmax = 1838, ymin = -Inf, ymax = Inf), 
            fill = NA, color = "black", linetype = "dotdash") +
  annotate("text", x = 1838, y = max(data$craftman_wage), label = "Poor Law", vjust = 13, fontface = "italic") +
  
  geom_line(aes(y = craftman_wage, linetype = "Craftman Wage"), color = "black") +
  geom_line(aes(y = general_wage, linetype = "General Wage"), color = "black") +
  labs(x = "Year", y = "Wage", title = "Craftman Wage vs. General Wage") +

  scale_linetype_manual(name = "Type", values = c("Craftman Wage" = "solid", "General Wage" = "dashed")) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = c(0.999, 0.18), 
        legend.justification = "right",
        legend.box.just = "right")
dev.off()

pdf("grainprice.pdf", width=6.27, height=3.54)
ggplot(data, aes(x = Year)) +
  geom_rect(aes(xmin = 1845, xmax = 1851, ymin = -Inf, ymax = Inf), 
            fill = "#E4745E", color = "black", linetype = "dotdash") +
  annotate("text", x = 1848, y = max(data$potato_price), label = "Great Famine", vjust = -1, fontface = "italic") +
  geom_rect(aes(xmin = 1877, xmax = 1879, ymin = -Inf, ymax = Inf), 
            fill = "#FED59E", color = "black", linetype = "dotdash") +
  annotate("text", x = 1878, y = max(data$potato_price), label = "Land War", vjust = -1, fontface = "italic") +
  geom_rect(aes(xmin = 1838, xmax = 1838, ymin = -Inf, ymax = Inf), 
            fill = NA, color = "black", linetype = "dotdash") +
  annotate("text", x = 1838, y = max(data$potato_price), label = "Poor Law", vjust = 3, fontface = "italic") +
  
  geom_line(aes(y = oat_price, color = "Oat Price"), size=0.4) +
  geom_line(aes(y = potato_price, color = "Potato Price"), size=0.4) +
  geom_line(aes(y = wheat_price, color = "Wheat Price"), size=0.4) +
  geom_line(aes(y = barley_price, color = "Barley Price"), size=0.4) +
  labs(x = "Year", y = "Price", title = "Grain Prices Over Time") +
  scale_y_continuous(limits = c(0, 25), breaks = seq(0, 25, 5)) +
  scale_color_manual(name = "Crop",
                     values = c("Oat Price" = "#68be8d",
                                "Potato Price" = "#e6b422",
                                "Wheat Price" = "#8c6450",
                                "Barley Price" = "#38a1db")) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = c(0.999, 0.75),
        legend.justification = "right",
        legend.box.just = "right",
        legend.text = element_text(size = 8), 
        legend.title = element_text(size = 10))  
dev.off()


indices_to_label <- c(27)

pdf("pricecatter.pdf", width=5, height=5)
ggplot(data, aes(x = oat_price, y = potato_price)) +
  geom_point(color = "#4793AF", fill="white", size = 3, shape = 1) +  # Customize point color, size, and shape
  geom_smooth(method = "lm", se = TRUE, color = "#E4745E") +  # Add a linear trend line with confidence interval
  annotate("text", x = 12.78, y = 15.8, label = "1855") +
  annotate("text", x = 8.62, y = 23.3, label = "1846") +
  annotate("text", x = 5.1, y = 2.5, label = "1832") +
  annotate("text", x = 10, y = 18.4, label = "1847") +
  annotate("text", x = 11.16, y = 21.6, label = "1854") +
  labs(x = "Oat Price", y = "Potato Price", title = "Scatter Plot of Oat Price vs. Potato Price") +
  theme_bw() +
  theme(panel.grid = element_blank())
dev.off()








