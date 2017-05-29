# From: http://shiny.rstudio.com/articles/basics.html
library(shiny)

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
    source('./scripts/GetInfo.R')
    
    info <- GetInfo(survey.data)
  })
  
})