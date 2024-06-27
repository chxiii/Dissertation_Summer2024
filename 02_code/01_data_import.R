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

#####################
# Here is all the palette
#####################

# Les Peupliers - Monet
palette <- c("#E0D7C1", "#97B0C0", "#90A796", "#627F44")

# Wheat Field with Sheaves and a Windmill - Van Gogh
palette <- c("#EACE22", "#D9A615", "#8E6124", "#343660")

# Cloudy Wheat Field - Van Gogh
palette <- c("#CDDCDA", "#B2CCB3", "#769692", "#4C6AA8")

# The Starry Night - Van Gogh
palette <- c("#FBF1D8", "#FCE468", "#5F93DE", "#323A7E")




# set dictionary
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

df <- read_excel("../01_data/Irish_19th_century_data.xlsx", sheet = 1)

food_struct <- data.frame(
  Year = df$year,
  wheat_yield = df$wheat_yield,
  oat_yield = df$oat_yield,
  barley_yield = df$barley_yield,
  potato_yield = df$potato_yield
)

year_filter<- df %>%
  filter((year >= 1821 & year <= 1825) |
           (year >= 1845 & year <= 1851) |
           (year >= 1896 & year <= 1900))

year_filter <- year_filter %>%
  mutate(total_yield = wheat_yield + oat_yield + barley_yield + potato_yield)

year_filter$year <- as.character(year_filter$year)

placeholder_years <- data.frame(
  year = c("1826-1844", "1852-1895"),
  wheat_yield = c(NA, NA),
  oat_yield = c(NA, NA),
  barley_yield = c(NA, NA),
  potato_yield = c(NA, NA),
  total_yield = c(NA, NA)
)

# 合并数据和空档
combined_df <- bind_rows(year_filter, placeholder_years) %>%
  arrange(year)

# 转换数据格式
long_df <- combined_df %>%
  pivot_longer(cols = c(wheat_yield, oat_yield, barley_yield, potato_yield),
               names_to = "Crop",
               values_to = "Yield")

# stacked
food_structure <- ggplot() +
  geom_bar(
    data = long_df, aes(x = factor(year), y = Yield, fill = Crop),
    stat = "identity", position = "fill", na.rm = TRUE, color = "black", linewidth = 0.3) +
  scale_y_continuous(
    labels = scales::percent,
    sec.axis = sec_axis(~ . * max(combined_df$total_yield, na.rm = TRUE), name = "Total Yield")) +
  labs(
    title = "Grain Percentage Stacked, by Year",
    x = NULL,
    y = "Percentage"
  ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom") +
  guides(fill = guide_legend(title = "Crop")) +
  scale_fill_manual(values = c("wheat_yield" = "#CDDCDA", "oat_yield" = "#B2CCB3", 
                               "barley_yield" = "#769692", "potato_yield" = "#4C6AA8")) +
  scale_fill_manual(values = c("wheat_yield" = "#D1BDC1", "oat_yield" = "#DAAE8D", 
                             "barley_yield" = "#CE7C56", "potato_yield" = "#15564E"))
# add a line plot
food_structure <- food_structure +
  geom_line(data = combined_df, aes(x = factor(year), y = total_yield / max(total_yield, na.rm = TRUE), group=1), 
            color = "#4C6AA8", size = 1, na.rm = TRUE) +
  geom_point(data = combined_df, aes(x = factor(year), y = total_yield / max(total_yield, na.rm = TRUE), group=1), 
             color = "#4C6AA8", size = 1.5, na.rm = TRUE)

# print plot
print(food_structure)
# save plot
ggsave("../03_outputs/food_structure.pdf", plot = food_structure, dpi = 300, width=7, height=5)
  #scale_fill_manual(values = c("wheat_yield" = "#D8DEE0", "oat_yield" = "#7E9AC9", 
  #                             "barley_yield" = "#B68F15", "potato_yield" = "#293D36"))



