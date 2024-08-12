source("reg.model.R")

# 原始的常项数据框
coeff_df <- data.frame(
  Term = c("Intercept", "potato_price", "ground_rent", "factor(if_tithe)1", "factor(poorlaw)1", "imports_total"),
  Estimate = c(-7.420286, -0.078810, 0.341847, 0.449962, 3.615946, 0.043979),
  Std.Error = c(1.391151, 0.027888, 0.117535, 0.559427, 0.616612, 0.007962),
  Pr = c(0.000001364, 0.00629, 0.00500, 0.42421, 0.000000176, 0.000000660),
  Signif = c("***", "**", "**", "", "***", "***")
)

coeff_df$CI.Lower <- coeff_df$Estimate - 1.96 * coeff_df$Std.Error
coeff_df$CI.Upper <- coeff_df$Estimate + 1.96 * coeff_df$Std.Error
coeff_df$Color <- ifelse(coeff_df$Signif == "", "#454b87", "#bd3106")

coeff_df$Term <- factor(coeff_df$Term, levels = rev(c("Intercept", "potato_price", "imports_total", "ground_rent", 
                                                      "factor(poorlaw)1", "factor(if_tithe)1")))


# 绘制回归系数图表（常项）
point <- ggplot(coeff_df, aes(x = Estimate, y = Term)) +
  geom_errorbarh(aes(xmin = CI.Lower, xmax = CI.Upper), height = 0.3, color = "gray") +
  geom_point(aes(color = Color), size = 2) +
  labs(title = "Regression Coefficients (Linear Terms)", x = "Coefficient Estimate", y = "") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_text(angle = 0),
        legend.position = "none") +
  scale_color_identity()

print(point)

coef.visual <- point + 
  
  (s.grainprice + s.generalw + plot_layout(nrow = 2)) +
  
  plot_layout(ncol = 2, widths = c(1, 1))
  
print(coef.visual)
