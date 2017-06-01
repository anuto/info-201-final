library(shiny)
library(plotly)
library(plyr)
library(dplyr)
library(stringi)
library(shinyLP)
library(gdata)
library(knitr)
library(shiny.router)
library(shinydashboard)

shinyServer(function(input, output, session) {

  output$assaultMap <- renderPlotly({
    source('./scripts/map.R')

    assault.map.data <- read.csv("./data/full.map.data.csv", stringsAsFactors = FALSE)
    
    year <- input$map.year.slider
    if (year > 2009) {year <- year %% 100} else {year <- year %% 10}
    
    public.school <- input$public.school
    private.school <- input$private.school
    
    if (public.school && private.school) {
      public.school <- ""
      private.school <- ""
    } else if(public.school) {
      public.school <- "Public"
      private.school <- ""
    } else if (private.school) {
      private.school <- "Private"
      public.school <- ""
    } 
    
    min <- input$map.population[1]
    max <- input$map.population[2]
    
    # select only the data specified in maps of the year/population size/rank specified here
    if (year == 5) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL5, rape = RAPE5) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 6) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL6, rape = RAPE6) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 7) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL7, rape = RAPE7) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 8) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL8, rape = RAPE8) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 9) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL9, rape = RAPE9) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 10) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL10, rape = RAPE10) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 11) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL11, rape = RAPE11) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 12) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL12, rape = RAPE12) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 13) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL13, rape = RAPE13) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 14) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL14, rape = RAPE14) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    } else if (year == 15) {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL15, rape = RAPE15) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min))
    }

  })
  
  output$timeline <- renderPlotly ({
    source('./scripts/timeline.R')
    df <- read.csv('./data/title.ix.cases.csv')
    
    
    Timeline(input$oc, df)
  })
  
  output$au <- renderUI(includeHTML('aboutus.html'))
  
  output$report <- renderUI(includeHTML('index.html'))
  
    observeEvent(input$do, {
      updateNavbarPage(session, "timeline", selected = NULL)
    }
)
})