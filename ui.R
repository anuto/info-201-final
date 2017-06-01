library(shiny)
library(shinythemes)
library(plotly)
library(shinyLP)

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
  ),
  
  jumbotron("U.S College Campus Sexual Assaults","", button = FALSE),
  
  navbarPage("",
             tabPanel("Home",
                       panel_div(class_type = "primary", panel_title = 'About this project',
                                 content = "The purpose of this report is to inform perspective and current college students, 
                                            as well as their parents, about the campus safety in terms of sexual assault. After
                                            reading this report, we hope our target audiences can make a better decision about 
                                           what colleges to attend and increase current students’ awareness regarding their college’s safety."),
                        panel_div(class_type = 'primary', panel_title = "Structure",
                                  content = 'We have found data from the Department of Education on both reported and reported but 
                                              mishandled sexual assaults on college campuses. Please refer to “About the Data” for
                                              more information. Using these data, we create an interactive map to display sexual 
                                                assaults by location. You can explore data from 2005 to 2015 based on different criterias. 
                                              Additionally, we create a time line to present the mishandled sexual assault cases. We also 
                                              provide our insightful findings and suggestion for your reference.'),                    
             fluidRow(
               column(4, thumbnail_label(image = NULL, label = 'Explore by location',
                                         content = 'See the distribution of reported sexual assaults across 
                                         college campuses in the US over the last decade. Compare and contrast
                                         colleges by population, sector, and gender ratio.',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Explore map')
               ),
               column(3, thumbnail_label(image = "", label = 'Explore mishandled cases',
                                         content = 'In 2015 Department of Education investigated sexual assault
                                         cases involving student athletes. They found 400 cases to have been
                                         mishandled.',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Explore cases')
               ),
               column(4, thumbnail_label(image = "", label = 'Explore our solution',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               ),
               column(4, thumbnail_label(image = 'C:/Users/Althea/Desktop/info201/info-201-final/pics/map.PNG', label = 'Explore our findings',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'Get involved')
               
               ),
               column(3, thumbnail_label(image = "", label = 'Understanding our Data',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help protect students',
                                         button_link = 'http://getbootstrap.com/', button_label = 'See more')
               ),
               column(3, thumbnail_label(image = "", label = 'Meet the Team',
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
 
 