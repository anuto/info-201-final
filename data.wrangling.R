library(dplyr)
library(gdata)

data.05.07 <- read.xls('Oncampuscrime050607.xls', header = TRUE)
data.07.09 <- read.xls('Oncampuscrime070809.xls', header = TRUE)
data.09.11 <- read.xls('Oncampuscrime091011.xls', header = TRUE)
data.10.12 <- read.xls('Oncampuscrime101112.xls', header = TRUE)
data.13.15 <- read.xls('Oncampuscrime131415.xls', header = TRUE)

new <- merge(data.05.07, data.07.09, by=c('UNITID_P',"INSTNM", 'BRANCH', 'Address', 'City', 'State', 'ZIP', 
                                          'sector_cd', 'Sector_desc', 'men_total', 'women_total', 'Total'))
# "UNITID_P","INSTNM", 'BRANCH', 'Address', 'City', 'State', 'ZIP', 'sector_cd', 'Sector_desc', 'men_total', 'women_total', 'Total'
new <- left_join(data.05.07, data.07.09)
new <- inner_join(data.05.07, data.07.09)
