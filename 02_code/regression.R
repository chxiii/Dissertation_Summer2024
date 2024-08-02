source("main.R")

plot.scatter <- function(data, x, y){
  ggplot(data, aes_string(x = x, y = y)) +
    
    geom_point(color = met.brewer("VanGogh1")[2], size = 1.5, shape = 1) + 
    
    theme_bw() +
    
    theme(panel.grid = element_blank())
}

reg_x <- c("potato_price", "grain_price_other", "ground_rent", 
           "general_wage", "inventories", "grain_acre_total")

p <- lapply(reg_x, function(i) plot.scatter(df, i, "popgap"))

reg_scatter <- wrap_plots(p, ncol=2)
reg_scatter

ggsave("../03_outputs/regression_scatter.pdf", 
       plot = reg_scatter, dpi = 300, width = 7, height = 7)

corr_matrix <- cor(df %>% select(-popgap), use = "complete.obs")

ggcorrplot(corr_matrix, lab = TRUE)

reg <- gam(popgap ~ s(potato_price) + grain_price_other +
                    if_tithe + poorlaw + ground_rent + general_wage +
                    inventories, data = df)

gam.check(reg)

summary(reg)
plot(reg)





cor(df$popgap, df$total_acre)

reg1 <- gam(popgap ~ s(grain_acre_total), data = df)
summary(reg1)         
plot(reg1)                          
