source("main.R")

##### function for scatter matrix #####

plot.scatter <- function(data, x, y){
  ggplot(data, aes_string(x = x, y = y)) +
    
    geom_point(color = met.brewer("VanGogh1")[2], size = 1.5, shape = 1) + 
    
    theme_bw() +
    
    theme(panel.grid = element_blank())
}

reg_x <- c("potato_price", "grain_price_other", "ground_rent", 
           "general_wage", "imports_total", "exports_total")

p <- lapply(reg_x, function(i) plot.scatter(df, i, "popgap"))

reg_scatter <- wrap_plots(p, ncol=2)
reg_scatter

ggsave("../03_outputs/regression_scatter.pdf", 
       plot = reg_scatter, dpi = 300, width = 7, height = 7)

rm(list = ls())
