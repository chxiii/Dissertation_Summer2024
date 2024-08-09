source("reg.model.R")

summary(reg.ori.gam)

summary(reg.lin)

# add time
reg.tim.gam <- gam(popgap ~ potato_price + s(grain_price_other) + # H1
                                    
                                    ground_rent + factor(if_tithe) +  #H2
                                    
                                    s(general_wage) + #H3 
                                    
                                    imports_total + s(exports_total) + factor(poorlaw) + #H4,
                                  
                                    year,
                                  
                                  data = df)

summary(reg.tim.gam)

# use different NA deal way



df_pre_1847 <- subset(df, year <= 1847)
df_post_1847 <- subset(df, year > 1847)

# 
gam_pre_1847 <- gam(popgap ~ potato_price + s(grain_price_other) +
                      ground_rent + factor(if_tithe) + 
                      s(general_wage) + 
                      imports_total + s(exports_total) + factor(poorlaw),
                    data = df_pre_1847)
summary(gam_pre_1847)

# 对1847年后的数据建模
gam_post_1847 <- gam(popgap ~ potato_price + s(grain_price_other) +
                       ground_rent + factor(if_tithe) + 
                       s(general_wage) + 
                       imports_total + s(exports_total) + factor(poorlaw),
                     data = df_post_1847)
summary(gam_post_1847)
