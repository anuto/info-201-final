library(shiny)
library(shinythemes)

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
                        selectInput("school.type", "Public/Private/Both:", choices = list("Public", "Private", "Both")),
                        # textInput("txt", "Search by location :", "text here"),
                        sliderInput("map.year.slider", "Year:", 2005, 2015, 1, sep = ""),
                        selectInput("population.group.choice", "Choose campus size:", choices = list("Large", "Medium", "Small"))
                        # actionButton("action2", "Button2", class = "btn-primary")
                        
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("Tab 1"),
                          tabPanel("Tab 2")
                        ),
                        plotlyOutput("assaultMap"))
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
            tabPanel("Moving Forwards"
            )
             
  )))
 
 