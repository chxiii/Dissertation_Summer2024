source("main.R")

p1 <- ggplot(df, aes(x = potato_price, y = popgap)) +
  geom_point() + 
  theme_bw()
p1

p1 <- ggplot(df, aes(x = wheat_price, y = popgap)) +
  geom_point() + 
  theme_bw()
p1

p1 <- ggplot(df, aes(x = oat_price, y = popgap)) +
  geom_point() + 
  theme_bw()
p1

p1 <- ggplot(df, aes(x = barley_price, y = popgap)) +
  geom_point() + 
  theme_bw()
p1

p1 <- ggplot(df, aes(x = other_grain_price, y = popgap)) +
  geom_point() + 
  theme_bw()
p1

p1 <- ggplot(df, aes(x = ground_rent, y = popgap)) +
  geom_point() + 
  theme_bw()
p1

p2 <- ggplot(df, aes(x = total_acre, y = popgap)) +
  geom_point() + 
  theme_bw()
p2

p2 <- ggplot(df, aes(x = general_wage, y = popgap)) +
  geom_point() + 
  theme_bw()
p2

p2 <- ggplot(df, aes(x = imports_total, y = popgap)) +
  geom_point() + 
  theme_bw()
p2

p2 <- ggplot(df, aes(x = exports_total, y = popgap)) +
  geom_point() + 
  theme_bw()
p2

p2 <- ggplot(df, aes(x = total_acre, y = popgap)) +
  geom_point() + 
  theme_bw()
p2



reg <- gam(popgap ~ s(potato_price) + other_grain_price +
                    if_tithe + ground_rent + general_wage +
                    s(imports_total) + s(exports_total), data = df)
summary(reg)
plot(reg)

cor(df$popgap, df$total_acre)

reg1 <- gam(popgap ~ s(total_acre), data = df)
summary(reg1)         
plot(reg1)                          
