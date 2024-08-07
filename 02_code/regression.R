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



reg.ori.gam <- gam(popgap ~ potato_price + s(grain_price_other) + # H1
                     
                     ground_rent + factor(if_tithe) +  #H2
                     
                     s(general_wage) + #H3 
                     
                     imports_total + factor(poorlaw)  # H4
                   
                   ,
                   
                   data = df)

AIC(reg.ori.gam)

summary(reg.ori.gam)
plot(reg.ori.gam, page = 1)

df %>% ggplot(aes(ground_rent, popgap))+
  geom_point()+
  geom_smooth(method = "gam")

reg.fad.gam <- gam(popgap ~ grain_acre_total, data = df)
summary(reg.fad.gam)

reg.lin <- lm(popgap ~ potato_price + grain_price_other + 
                
                ground_rent + factor(if_tithe) + 
                
                general_wage + 
                
                imports_total + factor(poorlaw), 
              
              data = df)

AIC(reg.lin)

summary(reg.lin)

vif(reg.lin)




gam.check(reg.upd.gam)




residuals <- residuals(reg.upd.gam)

qqdata <- qqnorm(residuals, plot.it = FALSE)

qq.df <- as.data.frame(qqdata)
colnames(qq.df) <- c("theoretical", "sample")


# QQ plot
qq.plot <- ggplot(qq.df, aes(x = theoretical, y = sample)) +
  
  geom_point(col = met.brewer("VanGogh2")[8]) +
  
  geom_abline(intercept = coef(lm(sample ~ theoretical, data = qq.df))[1], 
              slope = coef(lm(sample ~ theoretical, data = qq.df))[2], 
              col = met.brewer("VanGogh2")[1]) +
  
  theme_bw() + 
  
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank()) +
  
  labs(title = "Normal QQ Plot of Residuals", x = "Theoretical Quantiles", y = "Sample Quantiles")

print(qq.plot)


acf(residuals(reg.upd.gam))

shapiro.test(residuals(reg.upd.gam))

# AIC check
reg.lm <- lm(popgap ~ potato_price + grain_price_other + # H1
               
               ground_rent + if_tithe + #H2
               
               general_wage + #H3 
               
               poorlaw +  #H4
               
               year,
             
             data = df)

summary(reg.lm)

AIC(reg.lm)

dwtest(reg.lm)




cor(df$popgap, df$total_acre)

reg1 <- gam(popgap ~ s(grain_acre_total), data = df)
summary(reg1)         
plot(reg1)                          
