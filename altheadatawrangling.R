# install.packages("stringi")
# get libraries
library(dplyr)
library(gdata)
library(zipcode)
library(stringi)

# get rid of weird formats
clean <- function(data, sortby) {
  data[, sortby] <- as.numeric(as.character(data[, sortby]))
  return(data)
}

CleanZip <- function(zip) {
  zip.length <- stri_length(as.character(zip))
  if (zip.length > 5) {
    diff <- zip.length - 5
    zip <-trunc((zip / (10 ^ diff)), prec = -2)
    
  }
  return(zip)
}

# import the '05-'07 dataset, get rid of weird stringsAsFactors stuff
data.05.07 <- read.xls('Oncampuscrime050607.xls', header = TRUE)
write.csv(data.05.07, "data.05.07.csv", row.names = FALSE)
data.05.07<- read.csv("data.05.07.csv", stringsAsFactors = FALSE)

# wrangling data to useful info, getting weird of weird nas
edited.data.05.07 <- data.05.07 %>%
  mutate("RAPE5" = FORCIB5 + NONFOR5, "RAPE6" = FORCIB6 + NONFOR6, "MEN5" = men_total,
         "WOMEN5" = women_total, "TOTAL5" = total) %>%
  select(INSTNM, sector_desc, MEN5, WOMEN5, TOTAL5, RAPE5, RAPE6, Zip)
edited.data.05.07 <- na.omit(edited.data.05.07)
edited.data.05.07$Zip <- as.numeric(edited.data.05.07$Zip)

# import that '07 - '09 dataset, get rid of weird stringsAsFactors stuff
data.07.09 <- read.xls('Oncampuscrime070809.xls', header = TRUE)
write.csv(data.07.09, "data.07.09.csv", row.names = FALSE)
data.07.09 <- read.csv("data.07.09.csv", stringsAsFactors = FALSE)

# wrangling the data to useful info, getting weird of weird nas
edited.data.07.09 <- data.07.09 %>%
  mutate("RAPE7" = FORCIB7 + NONFOR7, "RAPE8" = FORCIB8 + NONFOR8, "Zip" = ZIP, 
         "sector_desc" = Sector_desc, "TOTAL7" = Total, "MEN7" = men_total, 
         "WOMEN7" = women_total) %>%
  select(INSTNM, RAPE7, RAPE8, MEN7, WOMEN7, TOTAL7, Zip, sector_desc)

# getting rid of things to join, fixing nas, etc.
edited.data.07.09$Zip <- as.numeric(edited.data.07.09$Zip)
edited.data.07.09 <- na.omit(edited.data.07.09)

# joining tables -> '05 - '09
new <- full_join(edited.data.05.07, edited.data.07.09, by = c("INSTNM", "Zip", "sector_desc"))

# import the '09 - '11 dataset
data.09.11 <- read.xls('Oncampuscrime091011.xls', header = TRUE)
write.csv(data.09.11, "data.09.11.csv", row.names = FALSE)
data.09.11 <- read.csv("data.09.11.csv", stringsAsFactors = FALSE)

# cleaning weird columns (getting rid of nas, changing odd formatting, etc.)
mod.09.11 <- clean(data.09.11, "FORCIB9")
mod.09.11 <- clean(mod.09.11, "NONFOR9")
combo <- as.vector(mod.09.11$FORCIB9 + mod.09.11$NONFOR9)

# selecting only useful columns, standardizing column names
edited.data.09.11<- data.09.11 %>%
  mutate("RAPE9" = combo, "Zip" = ZIP, "TOTAL9" = Total, "WOMEN9" = women_total,
         "MEN9" = men_total, "sector_desc" = Sector_desc) %>%
  select(INSTNM, Zip, MEN9, WOMEN9, TOTAL9, RAPE9, sector_desc)

# getting table ready to join with full table, getting rid of nas
edited.data.09.11$Zip <- as.numeric(edited.data.09.11$Zip)
edited.data.09.11 <- na.omit(edited.data.09.11)

# making the full table -> '05 - '11
new <- full_join(new, edited.data.09.11, by = c("INSTNM", "Zip", "sector_desc"))

# import the '10 - '12 dataset
data.10.12 <- read.xls('Oncampuscrime101112.xls', header = TRUE)
write.csv(data.10.12, "data.10.12.csv", row.names = FALSE)
data.10.12 <- read.csv("data.10.12.csv", stringsAsFactors = FALSE)

# cleaning weird columns (fixing formatting, removing nas, etc)
mod.10.12 <- clean(data.10.12, "FORCIB10")
mod.10.12 <- clean(mod.10.12, "NONFOR10")
mod.10.12 <- clean(mod.10.12, "FORCIB11")
mod.10.12 <- clean(mod.10.12, "NONFOR11")
mod.10.12 <- clean(mod.10.12, "FORCIB12")
mod.10.12 <- clean(mod.10.12, "NONFOR12")
combo11 <- as.vector(mod.10.12$FORCIB11 + mod.10.12$NONFOR11)
combo12 <- as.vector(mod.10.12$FORCIB12 + mod.10.12$NONFOR12)

# selecting only useful columns / standardizing column names
edited.data.10.12<- data.10.12%>%
  mutate("RAPE10" = FORCIB10, "RAPE11" = combo11, "RAPE12" = combo12, "Zip" = ZIP,
         "sector_desc" = Sector_desc, "TOTAL10" = Total, "WOMEN10" = women_total, "MEN10" = men_total) %>%
  select(INSTNM, Zip, sector_desc, MEN10, WOMEN10, TOTAL10, RAPE10, RAPE11, RAPE12)

# removing nas / fixing formatting to join
edited.data.10.12 <- na.omit(edited.data.10.12)
edited.data.10.12$Zip <- as.numeric(edited.data.10.12$Zip)

# adding new data so that the full table -> '05 - '12
new <- full_join(new, edited.data.10.12, by = c("INSTNM", "Zip", "sector_desc"))

# importing the '13 - '15 dataset
data.13.15 <- read.xls('Oncampuscrime131415.xls', header = TRUE)
write.csv(data.13.15, "data.13.15.csv", row.names = FALSE)
data.13.15 <- read.csv("data.13.15.csv", stringsAsFactors = FALSE)

# selecting only useful columns / standardizing column names
edited.data.13.15 <- data.13.15%>%
  mutate("RAPE13" = FORCIB13 + NONFOR13, "Zip" = ZIP, "sector_desc" = Sector_desc, 
         "TOTAL13" = Total, "WOMEN13" = women_total, "MEN13" = men_total) %>%
  select(INSTNM, Zip, sector_desc, MEN13, WOMEN13, TOTAL13, RAPE13, RAPE14, RAPE15)

# removing nas / fixing formatting to join
edited.data.13.15$Zip <- as.numeric(edited.data.13.15$Zip)
edited.data.13.15 <- na.omit(edited.data.13.15)

# joining the new dats such that the full dataset is now complete ('05 - '15)
new <- full_join(new, edited.data.13.15, by = c("INSTNM", "Zip", "sector_desc"))

# write the dataset to a .csv
write.csv(new, "Total.sexual.assaults.05.15.csv", row.names = FALSE)
edited.data.13.15<- data.13.15%>%
  mutate("RAPE13" = FORCIB13 + NONFOR13, "Zip" = ZIP, "sector_desc" = Sector_desc, "total" = Total) %>%
  select(INSTNM, Address, City, State, Zip, sector_cd, sector_desc, men_total, women_total, total, RAPE13, RAPE14, RAPE15)

# Zip fixes
new$Zip <- lapply(new$Zip, CleanZip)
new$Zip <- as.numeric(new$Zip)
SAVE <- new

colnames(new)
View(new)

# eliminating duplicates
new2 <- new %>% group_by(INSTNM, sector_desc) %>% summarize(RAPE13 = max(RAPE13), RAPE5 = max(RAPE5),
                                                            RAPE6 = max(RAPE6), RAPE7 = max(RAPE7), 
                                                            RAPE8 = max(RAPE8), RAPE9 = max(RAPE9),
                                                            RAPE10 = max(RAPE10), RAPE11 = max(RAPE11),
                                                            RAPE12 = max(RAPE12), RAPE14 = max(RAPE14),
                                                            RAPE15 = max(RAPE15)) %>% unique() 

write.csv(new2, "Total.sexual.assaults.05.15.csv", row.names = FALSE)
write.csv(x, "Updated.total.05.15.csv", row.names = FALSE)
x <- read.csv("Total.sexual.assaults.05.15.csv", stringsAsFactors = FALSE)
View(x)

install.packages("shinyLP")
