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

lapply(c("readxl", "ggplot2", "dplyr", "tidyr", "ggbreak"), pkgTest)

# set dictionary
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

df <- read_excel("../01_data/Irish_19th_century_data.xlsx", sheet = 1)

food_struct <- data.frame(
  Year = df$Year,
  wheat_yield = df$wheat_yield,
  oat_yield = df$oats_yield,
  barley_yield = df$barley_yield
  potato_yield = 
)

year_filter<- df %>%
  filter((Year >= 1821 & Year <= 1825) |
           (Year >= 1845 & Year <= 1849) |
           (Year >= 1896 & Year <= 1900))

year_filter$Year <- as.character(year_filter$Year)

placeholder_years <- data.frame(
  Year = c("1825-1844", "1849-1895"),
  wheat_yield = c(NA, NA),
  oats_yield = c(NA, NA),
  barley_yield = c(NA, NA)
)

# 合并数据和空档
combined_df <- bind_rows(year_filter, placeholder_years) %>%
  arrange(Year)

# 转换数据格式
long_df <- combined_df %>%
  pivot_longer(cols = c(wheat_yield, oats_yield, barley_yield),
               names_to = "Crop",
               values_to = "Yield")

# 绘制百分比堆积图
ggplot(long_df, aes(x = factor(Year), y = Yield, fill = Crop)) +
  geom_bar(stat = "identity", position = "fill", na.rm = TRUE) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Percentage Stacked Bar Chart with Year Gaps",
    x = "Year",
    y = "Percentage"
  ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



