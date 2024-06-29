source("main.R")

food_struct <- data.frame(
  Year = df$year,
  wheat_acre = df$wheat_acre,
  oat_acre = df$oat_acre,
  barley_acre = df$barley_acre,
  potato_acre = df$potato_acre
)

year_filter<- df %>%
  filter((year >= 1821 & year <= 1825) |
           (year >= 1845 & year <= 1851) |
           (year >= 1896 & year <= 1900))

year_filter <- year_filter %>%
  mutate(total_acre = wheat_acre + oat_acre + barley_acre + potato_acre)

year_filter$year <- as.character(year_filter$year)

placeholder_years <- data.frame(
  year = c("1826-1844", "1853-1895"),
  wheat_acre = c(NA, NA),
  oat_acre = c(NA, NA),
  barley_acre = c(NA, NA),
  potato_acre = c(NA, NA),
  total_acre = c(NA, NA)
)

combined_df <- bind_rows(year_filter, placeholder_years) %>%
  arrange(year)

long_df <- combined_df %>%
  pivot_longer(cols = c(wheat_acre, oat_acre, barley_acre, potato_acre),
               names_to = "Crop",
               values_to = "acre")

food_structure <- ggplot() +
  geom_bar(
    data = long_df, 
    aes(x = factor(year), y = acre, fill = Crop),
    stat = "identity", 
    position = "fill", na.rm = TRUE, color = "black", linewidth = 0.3) +
  
  scale_y_continuous(
    labels = scales::percent,
    sec.axis = sec_axis(~ . * max(combined_df$total_acre, na.rm = TRUE), 
                        name = "Total acre")) +
  
  labs(
    title = "Grain Percentage Stacked, by Year",
    x = NULL,
    y = "Percentage"
  ) +
  
  annotate("text", x = "1848", y = -0.05, label = "|-------- Great Famine --------|", fontface = "italic", size = 3) +
  
  theme_classic() +
  
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom") +
  
  guides(fill = guide_legend(title = "Crop")) +
  
  scale_fill_manual(values = c("wheat_acre" = "#D1BDC1", 
                               "oat_acre" = "#DAAE8D", 
                               "barley_acre" = "#CE7C56", 
                               "potato_acre" = "#15564E"))

# add a line plot
food_structure <- food_structure +
  
  geom_line(data = combined_df, aes(x = factor(year), 
                                    y = total_acre / max(total_acre, na.rm = TRUE), 
                                    group=1), 
            color = "#4C6AA8", size = 1, na.rm = TRUE) +
  
  geom_point(data = combined_df, aes(x = factor(year), 
                                     y = total_acre / max(total_acre, na.rm = TRUE), 
                                     group=1), 
             color = "#4C6AA8", size = 1.5, na.rm = TRUE)

# print plot
print(food_structure)

# save plot
ggsave("../03_outputs/food_structure.pdf", 
       plot = food_structure, dpi = 300, width=7, height=5)

