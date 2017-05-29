library(zipcode)
library(dplyr)


final.df <- read.csv("./data/Total.sexual.assaults.05.15.csv", stringsAsFactors = FALSE)
final.df$Zip <- substr(final.df$Zip, 1, 5)
final.df <- full_join(final.df, zipcode, by)
names(final.df)[names(final.df) == 'Zip'] <- 'zip'
final.df <- full_join(final.df, zipcode, by = 'zip')
write.csv(final.df, './data/final.data.csv', row.names = FALSE)
