source("main.R")

reg.lin <- lm(popgap ~ potato_price + grain_price_other + 
                
                ground_rent + factor(if_tithe) + 
                
                general_wage + 
                
                imports_total + exports_total + factor(poorlaw), 
              
              data = df)

AIC(reg.lin)
summary(reg.lin)
stargazer(reg.lin)
vif(reg.lin)

reg.ori.gam <- gam(popgap ~ potato_price + s(grain_price_other) + # H1
                     
                     ground_rent + factor(if_tithe) +  #H2
                     
                     s(general_wage) + #H3 
                     
                     imports_total + s(exports_total) + factor(poorlaw), #H4,
                   
                   data = df)

gam.check(reg.ori.gam)

# Assuming reg.ori.gam is your fitted model
fit <- fitted(reg.ori.gam)
res <- residuals(reg.ori.gam)

# Residuals vs Fitted Plot
p1.res <- ggplot(data = data.frame(Fitted = fit, Residuals = res), aes(x = Fitted, y = Residuals)) +
  geom_point(color = met.brewer("Monet")[7], shape = 1) +
  # geom_smooth(method = "loess", se = FALSE, color = met.brewer("Monet")[6]) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "P1.Residuals", x = "Fitted Values", y = "Residuals") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())
print(p1.res)

p2.qq <- ggplot(data = data.frame(sample = res), aes(sample = sample)) +
  stat_qq(color = met.brewer("Monet")[7], shape = 1) +
  stat_qq_line(color = met.brewer("Monet")[6]) +
  labs(title = "P2.Q-Q", x = "Theoretical Quantiles", y = "Sample Quantiles") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())
print(p2.qq)

resp <- reg.ori.gam$y  # assuming your response variable is the one used in the model

# Response vs Fitted Plot
p3.resp <- ggplot(data = data.frame(Fitted = fit, Response = resp), aes(x = Fitted, y = Response)) +
  geom_point(color = met.brewer("Monet")[7], shape = 1) +
  # geom_smooth(method = "loess", se = FALSE, color = met.brewer("Monet")[6]) +
  labs(title = "P3.Response", x = "Fitted Values", y = "Response") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())
print(p3.resp)

p4.reshist <- ggplot(data = data.frame(Residuals = res), aes(x = Residuals)) +
  geom_histogram(binwidth = 0.4, color = "black", fill = met.brewer("Monet")[8]) +
  labs(title = "P4.HistResiduals", x = "Residuals", y = "Frequency") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())
print(p4.reshist)

regcheck <- p1.res + p2.qq + p3.resp + p4.reshist +
  
  plot_layout(ncol = 2)

print(regcheck)

ggsave("../03_outputs/regcheck.pdf", 
       plot = regcheck, dpi = 300, width = 7, height = 5)



acf(residuals(reg.upd.gam))

shapiro.test(residuals(reg.upd.gam))



reg.fad.lm <- lm(popgap ~ grain_acre_total, data = df)

AIC(reg.fad.lm)

summary(reg.fad.lm)

stargazer(reg.fad.lm)











