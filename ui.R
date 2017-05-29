library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  navbarPage("US College Campus Sexual Assaults",
             tabPanel("Maps",
                      headerPanel("Sexual Assaults by Location"),
                      
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
             tabPanel("Report"
                      
             ),
             tabPanel("About this data"
                        
             ),
             tabPanel("About us"
            )
             
  )))
 
 