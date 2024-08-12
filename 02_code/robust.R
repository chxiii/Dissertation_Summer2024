source("reg.model.R")

summary(reg.ori.gam)
stargazer(reg.ori.gam)

summary(reg.lin)
stargazer(reg.lin)

# add time
reg.tim.gam <- gam(popgap ~ potato_price + s(grain_price_other) + # H1
                                    
                                    ground_rent + factor(if_tithe) +  #H2
                                    
                                    s(general_wage) + #H3 
                                    
                                    imports_total + s(exports_total) + factor(poorlaw) + #H4,
                                  
                                    year,
                                  
                                  data = df)

summary(reg.tim.gam)



df.pre1847 <- subset(df, year <= 1860)

# 
reg.pre.gam <- gam(popgap ~ potato_price + s(grain_price_other) +
                      ground_rent + factor(if_tithe) + 
                      general_wage + 
                      imports_total + s(exports_total) + factor(poorlaw),
                    data = df.pre1847)
summary(reg.pre.gam)
stargazer(reg.pre.gam)


# change another way to fill the NA
df.rob <- read_excel("../01_data/Irish_19th_century_data.xlsx", sheet = 1)

df.rob <- mice(df.rob, method = "norm.predict", m = 5, seed = 42)
df.rob <- complete(df.rob, 1)

df.rob$grain_price_other <- df.rob$wheat_price + df.rob$oat_price + df.rob$barley_price

df.rob$grain_acre_total <- df.rob$potato_acre + df.rob$wheat_acre + df.rob$oat_acre + df.rob$barley_acre

df.rob$imports_total <- df.rob$wheat_imports + df.rob$barley_imports + df.rob$oat_imports 

index <- df.rob$imports_total[1]
scale.f <- 100 / index
df.rob$imports_total <- df.rob$imports_total * scale.f

df.rob$exports_total <- df.rob$wheat_exports + df.rob$barley_exports + df.rob$oat_exports

reg.nor.gam <- gam(popgap ~ potato_price + s(grain_price_other) +
                     ground_rent + factor(if_tithe) + 
                     s(general_wage) + 
                     imports_total + s(exports_total) + factor(poorlaw),
                   data = df.rob)
summary(reg.nor.gam)
stargazer(reg.nor.gam)
