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
                       panel_div(class_type = "primary", panel_title = 'About this project',
                                 content = "We have found data from the Department of Education on both
                                 reported and reported but mishandled sexual assaults on college campuses.
                                 We have created visualizations to illustrate this data, a report to summarise,
                                 and a list of resources to help solve this problem."),
             fluidRow(
               column(2, thumbnail_label(image = NULL, label = 'Explore by location',
                                         content = 'See the distribution of reported sexual assaults across 
                                         college campuses in the US over the last decade. Compare and contrast
                                         colleges by population, sector, and gender ratio.',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Explore map')
               ),
               column(2, thumbnail_label(image = "", label = 'Explore mishandled cases',
                                         content = 'In 2015 Department of Education investigated sexual assault
                                         cases involving student athletes. They found 400 cases to have been
                                         mishandled.',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Explore cases')
               ),
               column(2, thumbnail_label(image = "", label = 'Explore our solution',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               ),
               column(2, thumbnail_label(image = 'C:/Users/Althea/Desktop/info201/info-201-final/pics/map.PNG', label = 'Explore our findings',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               
               ),
               column(2, thumbnail_label(image = "", label = 'Understanding our Data',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'See more')
               ),
               column(2, thumbnail_label(image = "", label = 'Meet the Team',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'See more')
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
 
 