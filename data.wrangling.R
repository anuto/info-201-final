install.packages("gdata")

library(dplyr)
library(gdata)

clean <- function(data, sortby) {
  data[, sortby] <- as.numeric(as.character(data[, sortby]))
  return(data)
}

data.05.07 <- read.xls('Oncampuscrime050607.xls', header = TRUE)
write.csv(data.05.07, "data.05.07.csv", row.names = FALSE)
data.05.07<- read.csv("data.05.07.csv", stringsAsFactors = FALSE)
edited.data.05.07 <- data.05.07 %>%
                mutate("RAPE5" = FORCIB5 + NONFOR5, "RAPE6" = FORCIB6 + NONFOR6, "MEN5" = men_total,
                       "WOMEN5" = women_total, "TOTAL5" = total) %>%
                  select(INSTNM, sector_desc, MEN5, WOMEN5, TOTAL5, RAPE5, RAPE6, Zip)
edited.data.05.07 <- na.omit(edited.data.05.07)
edited.data.05.07$Zip <- as.numeric(edited.data.05.07$Z)

data.07.09 <- read.xls('Oncampuscrime070809.xls', header = TRUE)
write.csv(data.07.09, "data.07.09.csv", row.names = FALSE)
data.07.09 <- read.csv("data.07.09.csv", stringsAsFactors = FALSE)
edited.data.07.09 <- data.07.09 %>%
                mutate("RAPE7" = FORCIB7 + NONFOR7, "RAPE8" = FORCIB8 + NONFOR8, "Zip" = ZIP, 
                       "sector_desc" = Sector_desc, "TOTAL7" = Total, "MEN7" = men_total, 
                       "WOMEN7" = women_total) %>%
                 select(INSTNM, RAPE7, RAPE8, MEN7, WOMEN7, TOTAL7, Zip)
edited.data.07.09$Zip <- as.numeric(edited.data.07.09$Zip)

edited.data.07.09 <- na.omit(edited.data.07.09)

new <- full_join(edited.data.05.07, edited.data.07.09, by = "INSTNM")
copy.new <- new

data.09.11 <- read.xls('Oncampuscrime091011.xls', header = TRUE)
mod.09.11 <- clean(data.09.11, "FORCIB9")
mod.09.11 <- clean(mod.09.11, "NONFOR9")
combo <- as.vector(mod.09.11$FORCIB9 + mod.09.11$NONFOR9)
edited.data.09.11<- data.09.11 %>%
                      mutate("RAPE9" = combo, "Zip" = ZIP, "sector_desc" = Sector_desc, "total" = Total) %>%
                        select(INSTNM, Address, City, State, Zip, sector_cd, sector_desc, men_total, women_total, total, RAPE9)
edited.data.09.11 <- na.omit(edited.data.09.11)

new <- full_join

data.10.12 <- read.xls('Oncampuscrime101112.xls', header = TRUE)
mod.10.12 <- clean(data.10.12, "FORCIB10")
mod.10.12 <- clean(mod.10.12, "NONFOR10")
mod.10.12 <- clean(mod.10.12, "FORCIB11")
mod.10.12 <- clean(mod.10.12, "NONFOR11")
mod.10.12 <- clean(mod.10.12, "FORCIB12")
mod.10.12 <- clean(mod.10.12, "NONFOR12")
combo11 <- as.vector(mod.10.12$FORCIB11 + mod.10.12$NONFOR11)
combo12 <- as.vector(mod.10.12$FORCIB12 + mod.10.12$NONFOR12)
edited.data.10.12<- data.10.12%>%
  mutate("RAPE10" = FORCIB10, "RAPE11" = combo11, "RAPE12" = combo12, "Zip" = ZIP, "sector_desc" = Sector_desc, "total" = Total) %>%
  select(INSTNM, Address, City, State, Zip, sector_cd, sector_desc, men_total, women_total, total, RAPE10, RAPE11, RAPE12)

data.13.15 <- read.xls('Oncampuscrime131415.xls', header = TRUE)
edited.data.13.15<- data.13.15%>%
  mutate("RAPE13" = FORCIB13 + NONFOR13, "Zip" = ZIP, "sector_desc" = Sector_desc, "total" = Total) %>%
  select(INSTNM, Address, City, State, Zip, sector_cd, sector_desc, men_total, women_total, total, RAPE13, RAPE14, RAPE15)



new <- full_join(edited.data.05.07, edited.data.07.09, by = "INSTNM")
new <- full_join(new, edited.data.09.11, by = "INSTNM")
new <- full_join(new, edited.data.10.12, by = "INSTNM")
new <- full_join(new, edited.data.13.15, by = "INSTNM")

x <- colnames(new)
print(x)
new.filtered <- new %>%
                  mutate("Address" = Address.x, "City" = City.x, "Sector_cd" = sector_cd.x, 
                         "Sector_desc" = sector_desc.x, "Total.men" = men_total.x, 
                         "Total.women" = women_total.x, "Total" = total.x, "State" = State.x, 
                         "Zip" = Zip.x) %>%
                               select(INSTNM, Address, City, State, Zip, Sector_cd, Sector_desc, 
                                      Total.men, Total.women, Total, RAPE5, RAPE6, RAPE7.y, RAPE8, RAPE9.y,
                                      RAPE10, RAPE11, RAPE12, RAPE13.y, RAPE14, RAPE15)
