coeff_df <- data.frame(
  Term = c("(Intercept)", "potato_price", "ground_rent", "imports_total", "factor(poorlaw)1"),
  Estimate = c(-7.420286, -0.078810, 0.341847,  0.043979, 3.615946),
  Std.Error = c(1.391151, 0.027888, 0.117535,  0.007962, 0.616612),
  t.value = c(-5.334, -2.826, 2.908, 5.524, 5.864),
  P.Value = c(0.000001364, 0.00629, 0.00500, 0.000000660, 0.000000176)
)


coeff_df$CI.Lower <- coeff_df$Estimate - 1.96 * coeff_df$Std.Error
coeff_df$CI.Upper <- coeff_df$Estimate + 1.96 * coeff_df$Std.Error


ggplot(coeff_df, aes(x = Estimate, y = Term)) +
  geom_errorbarh(aes(xmin = CI.Lower, xmax = CI.Upper), height = 0.2) +  
  geom_point(color = met.brewer("VanGogh2")[1], size = 3) +  
  labs(title = "Regression Coefficients from GAM Model", x = "Coefficient Estimate", y = "") +
  theme_bw() +
  theme(axis.text.y = element_text(angle = 0))  

