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

FindCoordinates <- function(name) {
  query.params <- list(address = name, key = maps.app.id)
  maps.response <- GET(base.url.maps, query = query.params)
  maps.content <- content(maps.response, "text")
  maps.data <- fromJSON(maps.content)
  maps.data <- maps.data$results
  geometry <- maps.data$geometry
  coords <- geometry$location
  to.return <- as.list(c(name = name, coords))
  return(to.return)
}

college.names <- title.IX.data %>% group_by(college) %>% distinct()
college.names <- college.names$college
is.vector(college.names)
print(college.names)

# small.list <- c("University of Washington", "washington state university")
# small.list.coord <- (lapply(small.list, FindCoordinates))

coordinates <- (lapply(college.names, FindCoordinates))
print(coordinates)
GetLat <- function(coord) {
  lat <- c()
  for (item in coord) {
    lat <- c(lat, item$lat)
  }
  return(lat)
}

GetLong <- function(coord) {
  lat <- c()
  for (item in coord) {
    lat <- c(lat, item$lng)
  }
  return(lat)
}

GetName <- function(coord) {
  lat <- c()
  for (item in coord) {
    if (is.null(item$lat) && is.null(item$lng))
    lat <- c(lat, item$name)
  }
  return(lat)
}

lattitude <- GetLat(coordinates)
longitude <- GetLong(coordinates)
names <- GetName(coordinates)
print(coordinates)
print(names)
schools.and.coordinates <- data.frame(names, lattitude, longitude)
s.a.c <- data.frame(coordinates$name, coordinates$lattitude, coordinates$longitude)
\

install.packages("shinythemes")

#  data wrangling
