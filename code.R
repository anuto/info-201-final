install.packages("XML")

library(httr)
library(jsonlite)
library(XML)
library(dplyr)

base.url.titleIX <- "http://projects.chronicle.com/titleix/api/v1/cases/"
title.IX.response <- GET(base.url.titleIX)
title.IX.content <- content(title.IX.response, "text")
title.IX.data <- fromJSON(title.IX.content)

# base.url.wolfram <- "http://api.wolframalpha.com/v2/"
# app.id <- "YH7LPY-TVWEUKHEPE"
# query.params <- list(appid = app.id, input = "population%20of%20france")
# 
# wolfram.response <- GET(base.url.wolfram, query = query.params)
# wolfram.content <- content(wolfram.response, "text")
# wolfram.data <- xmlParse(wolfram.content)
# query.result <- wolfram.data$queryresult

base.url.maps <- "https://maps.googleapis.com/maps/api/geocode/json"
maps.app.id <- "AIzaSyCddaHkTvSYmsqCDwnFnvAMxhD0GFltFMU"

findCoordinates <- function(name) {
  query.params <- list(address = name, key = maps.app.id)
  maps.response <- GET(base.url.maps, query = query.params)
  maps.content <- content(maps.response, "text")
  maps.data <- fromJSON(maps.content)
  maps.data <- maps.data$results
  geometry <- maps.data$geometry
  coords <- geometry$location
  return(as.list(coords))
}

college.names <- title.IX.data %>% group_by(college) %>% distinct()
college.names <- unlist(college.names)
is.vector(college.names)
print(college.names)
coordinates <- as.list(lapply(college.names, findCoordinates))
print(coordinates)
