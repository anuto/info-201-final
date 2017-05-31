library(shiny)
library(shinythemes)
library(plotly)
library(shinyLP)

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
  ),
  
  jumbotron("US College Campus Sexual Assaults","", button = FALSE),
  
  navbarPage("",
             tabPanel("Home",
                       panel_div(class_type = "primary", panel_title = "Directions",
                                 content = "How to use the app"),
             fluidRow(
               column(4, thumbnail_label(image = './pics/map.PNG', label = 'Explore by location',
                                         content = 'See the distribution of reported sexual assaults across 
                                         college campuses in the US over the last decade. Compare and contrast
                                         colleges by population, sector, and gender ratio.',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Explore map')
               ),
               column(4, thumbnail_label(image = 'Rlogo.png', label = 'Explore mishandled cases',
                                         content = 'In 2015 Department of Education investigated sexual assault
                                         cases involving student athletes. They found 400 cases to have been
                                         mishandled.',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Explore cases')
               ),
               column(4, thumbnail_label(image = 'Rlogo.png', label = 'Explore our solution',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               ),
               column(4, thumbnail_label(image = 'Rlogo.png', label = 'Explore our findings',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               
               ),
               column(4, thumbnail_label(image = 'Rlogo.png', label = 'Understanding our Data',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               ),
               column(4, thumbnail_label(image = 'Rlogo.png', label = 'Meet the Team',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               )
             )
             ),
             tabPanel("Sexual Assaults by Location",
                      headerPanel("Sexual Assaults by Location"),
                      
                      # year, population, public/private
                      sidebarPanel(
                        selectInput("school.type", "Public/Private/Both:", choices = list("Public", "Private")),
                        sliderInput("map.year.slider", "Year:", 2005, 2015, 1, sep = ""),
                        selectInput("population.group.choice", "Choose campus size:", choices = list("Large", "Medium", "Small"))

                      ),
                      
                      mainPanel(plotlyOutput("assaultMap"))
             ),
             tabPanel("Mishandled Sexual Assaults",
                      headerPanel("As flagged by Title IX"),
                      sidebarPanel(
                        textInput("txt", "Search by school:", "text here"),
                        selectizeInput("state", "Search by state: ", "text here"),
                        selectInput("oc", "Open or closed cases?", choices = list("Open", "Closed")),
                        actionButton("action", "Button"),
                        actionButton("action2", "Button2", class = "btn-primary")
                        
                      ),
                      
                      mainPanel(plotlyOutput("timeline"))
             ),
             tabPanel("Summary of Findings",
                      includeMarkdown("index.Rmd")
             ),     
             tabPanel("About the Data",
                      includeMarkdown("aboutData.Rmd")
             ),
             tabPanel("Moving Forwards",
                      includeMarkdown("solution.Rmd")
             ),
             tabPanel("About us",
                      includeMarkdown("aboutus.Rmd")
            )
  ) ))
 
 