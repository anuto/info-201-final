# From: http://shiny.rstudio.com/articles/basics.html
library(shiny)
library(dplyr)
library(stringi)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$assaultMap <- renderPlotly({
    source('./scripts/map.R')

    assault.map.data <- read.csv("./data/full.map.data.csv", stringsAsFactors = FALSE)
    assault.map.data$TOTAL9 <- as.numeric(assault.map.data$TOTAL9)

    year <- input$map.year.slider
    if (year > 2009) {year <- year %% 100} else {year <- year %% 10}
    
    pop.group <- input$population.group.choice
    
    max <- 15000000000000
    min <- 15000
    if (pop.group == "Small") { 
      max <- 5000
      min <- 0
    } else if (pop.group == "Medium") {
      max <- 15000
      min <- 5000
    }
    
    t <- assault.map.data %>%
                 select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                 rename(assault.map.data$TOTAL9 = pop) %>% 
                 filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$pop < max, assault.map.data$pop > min)

    public.private <- "Public" #input$school.type

    # select only the data specified in maps of the year/population size/rank specified here
    if (year == 5) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   rename(pop = TOTAL5) %>% 
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL5 < max, assault.map.data$TOTAL5 > min))
    } else if (year == 6) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL6 < max, assault.map.data$TOTAL6 > min))
    } else if (year == 7) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL7 < max, assault.map.data$TOTAL7 > min))
    } else if (year == 8) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL8 < max, assault.map.data$TOTAL8 > min))
    } else if (year == 9) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL9 < max, assault.map.data$TOTAL9 > min))
    } else if (year == 10) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL10 < max, assault.map.data$TOTAL10 > min))
    } else if (year == 11) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL11 < max, assault.map.data$TOTAL11 > min))
    } else if (year == 12) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL12 < max, assault.map.data$TOTAL12 > min))
    } else if (year == 13) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL13 < max, assault.map.data$TOTAL13 > min))
    } else if (year == 14) {
      AssaultMap(assault.map.data %>%
                   select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL14 < max, assault.map.data$TOTAL14 > min))
    } else if (year == 15) {
      AssaultMap(assault.map.data %>%
                 select(ends_with(toString(year)), latitude, longitude, INSTNM, primary_city, county) %>%
                 filter(grepl(public.private, assault.map.data$sector_desc.x), assault.map.data$TOTAL15 < max, assault.map.data$TOTAL15 > min))
    }

  })
  
})