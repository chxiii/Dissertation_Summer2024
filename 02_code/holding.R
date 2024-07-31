source("main.R")

df <- data.frame(
  Year = c(1855, 1860, 1865, 1870, 1875, 1880, 1885, 1890, 1895, 1900),
  `acres1_5` = c(61800, 63500, 61400, 57500, 53600, 50000, 47500, 46300, 47700, 47700),
  `acres5_15` = c(127200, 129900, 126400, 124700, 122800, 119100, 115800, 115400, 115900, 115800),
  `acres15_30` = c(101500, 103700, 100500, 101700, 101500, 101200, 100500, 100300, 100000, 100200),
  `acres30_50` = c(55600, 56800, 55900, 56200, 56800, 56500, 56700, 56800, 57100, 57100),
  `acres50_100` = c(44900, 46000, 46100, 46600, 46600, 46900, 46800, 47100, 47400, 47700),
  `acres100_200` = c(19300, 19800, 19800, 19700, 19800, 20200, 20400, 20700, 20700, 20700),
  `acresover_200` = c(9200, 9300, 9200, 9000, 9000, 9200, 9100, 9200, 9000, 9000)
)

df_long <- melt(df, id.vars = "Year", variable.name = "Acre_Category", value.name = "Count")

ggplot(df_long, aes(x = Year, y = Count, fill = Acre_Category)) +
  geom_area() +
  theme_bw() +
  labs(title = "Area Plot of Holdings by Acre Category Over Time",
       x = "Year", y = "Number of Holdings", fill = "Acre Category")