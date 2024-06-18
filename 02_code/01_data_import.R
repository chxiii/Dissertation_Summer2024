#####################
# load libraries
# set wd
# clear global .envir
#####################

# remove objects
rm(list = ls())
# detach all libraries
detachAllPackages <- function() {
  basic.packages <- c("package:stats", "package:graphics", "package:grDevices", "package:utils", "package:datasets", "package:methods", "package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:", search())) == 1, TRUE, FALSE)]
  package.list <- setdiff(package.list, basic.packages)
  if (length(package.list) > 0) for (package in package.list) detach(package, character.only = TRUE)
}
detachAllPackages()

# load libraries
pkgTest <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# here is where you load any necessary packages
# ex: stringr
# lapply(c("stringr"), pkgTest)

lapply(c("readxl", "ggplot2", "dplyr", "tidyr", "magrittr"), pkgTest)

# set dictionary
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

df <- read_excel("../01_data/Irish_19th_century_data.xlsx", sheet = 1)



set.seed(123)  # for reproducibility
df <- data.frame(
  Year = 1821:1900,
  Variable1 = runif(80, 1, 10),
  Variable2 = runif(80, 1, 10),
  Variable3 = runif(80, 1, 10)
)

# 过滤数据
filtered_df <- df %>%
  filter((Year >= 1821 & Year <= 1825) |
           (Year >= 1845 & Year <= 1849) |
           (Year >= 1896 & Year <= 1900))

# 检查过滤后的数据
print(filtered_df)

# 转换数据格式
long_df <- filtered_df %>%
  pivot_longer(cols = starts_with("Variable"),
               names_to = "Variable",
               values_to = "Value")

# 检查转换后的数据
print(long_df)

# 绘制堆积柱状图
ggplot(long_df, aes(x = factor(Year), y = Value, fill = Variable)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(
    title = "Stacked Bar Chart for Selected Years",
    x = "Year",
    y = "Value"
  ) +
  theme_minimal()