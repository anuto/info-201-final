library(shiny)
library(shinythemes)
library(plotly)

shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  navbarPage("US College Campus Sexual Assaults",
             tabPanel("About the Data",
                      includeMarkdown("aboutData.Rmd")
             ),
             tabPanel("Sexual Assaults by Location",
                      headerPanel("Sexual Assaults by Location"),
                      
                      # year, population, public/private
                      sidebarPanel(
                        checkboxInput("public.school", "Public", value = TRUE),
                        checkboxInput("private.school", "Private", value = TRUE),
                        sliderInput("map.year.slider", "Year:", 2005, 2015, 1, sep = ""),
                        sliderInput("map.population", "Campus Population:", 0, 80000, 1000, value = c(0, 5000), dragRange = TRUE)
                      ),
                      
                      mainPanel(plotlyOutput("assaultMap"))
             ),
             tabPanel("Mishandled Sexual Assaults",
                      headerPanel("As flagged by Title IX"),
                      sidebarPanel(
                        textInput("txt", "Search by location :", "text here"),
                        sliderInput("slider", "Slider input:", 1, 100, 30),
                        actionButton("action", "Button"),
                        actionButton("action2", "Button2", class = "btn-primary")
                        
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("Tab 1"),
                          tabPanel("Tab 2")
                        ),
                        plotOutput("distPlot"))
             ),
             tabPanel("Summary of Findings",
                      includeMarkdown("index.Rmd")
             ),     
             tabPanel("About us",
                      includeMarkdown("aboutus.Rmd")
            ),
            tabPanel("Moving Forwards",
                     includeMarkdown("solution.Rmd")
            )
             
  )))
 
 