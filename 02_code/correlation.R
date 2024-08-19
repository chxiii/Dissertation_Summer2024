source("main.R")

# correlation variable name
cor_reg <- c("potato_price", "grain_price_other", "ground_rent", 
             "general_wage", "imports_total", "exports_total", "grain_acre_total", "popgap")

# extract variables
corvar <- df[ , cor_reg]

# calculate correlation matrix
cormar <- cor(corvar, use = "complete.obs")

p.cormar <- rcorr(as.matrix(corvar))
p.matrix <- p.cormar$P

corrmatrix <- ggcorrplot(cormar, 
                         p.mat = p.matrix,
                         colors = c(
                           met.brewer("VanGogh2")[1], 
                           "white", 
                           met.brewer("VanGogh2")[8]), 
                         method = "circle", 
                         outline.color = "black", 
                         lab = TRUE, type = "lower", lab_size = 4,
                         insig = "blank") + 
  
  labs(x = "", y = "", title = "Correlation Matrix Heatmap") +
  
  theme_bw() + 
  
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1))

print(corrmatrix)

ggsave("../03_outputs/corrmatrix.pdf", 
       plot = corrmatrix, dpi = 300, width = 7, height = 5)

rm(list = ls())
