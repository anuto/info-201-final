# From: http://shiny.rstudio.com/articles/basics.html
library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$assaultMap <- renderPlotly({
    assault.map.data <- read.csv("./data/Total.sexual.assaults.05.15.csv", stringsAsFactors = FALSE)
    source('./scripts/map.R')
    
    year <- 2011#input$map.year.slider
    if (year > 2009) {year <- year %% 100} else {year <- year %% 10}
    
    pop.group <- input$population.group.choice
    max <- 15000
    min <- 5000
    if (pop.group < 5000) { 
      max <- 5000
      min <- 0
    } else if (pop.group < 15000) {
      max <- 15000
      min <- 5000
    } else {
      max <- 1000000000
      min <- 15000
    }

    public.private <- input$school.type
    
    
    # select only the data specified in maps of the year/population size/rank specified here
    assault.map.data <- assault.map.data %>% 
      mutate(TOTAL11 = TOTAL10,
             TOTAL12 = TOTAL10,
             TOTAL6 = TOTAL5,
             TOTAL8 = TOTAL7,
             TOTAL14 = TOTAL13,
             TOTAL15 = TOTAL13) %>% 
      select(ends_with(toString(year)))
    
    #AssaultMap(assault.map.data)
  })
  
})