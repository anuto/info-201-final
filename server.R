library(shiny)
library(plotly)
library(plyr)
library(dplyr)
library(stringi)

shinyServer(function(input, output) {
  
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
    
    public.private <- input$school.type

    # select only the data specified in maps of the year/population size/rank specified here
    if (year == 5) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL5, rape = RAPE5) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 6) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL6, rape = RAPE6) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 7) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL7, rape = RAPE7) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 8) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL8, rape = RAPE8) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 9) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL9, rape = RAPE9) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 10) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL10, rape = RAPE10) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 11) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL11, rape = RAPE11) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 12) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL12, rape = RAPE12) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 13) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL13, rape = RAPE13) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 14) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL14, rape = RAPE14) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 15) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL15, rape = RAPE15) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.private, assault.map.data$sector_desc.x), pop < max, pop > min))
    }

  })
  
})