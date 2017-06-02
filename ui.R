require(shiny)
require(shinythemes)
require(plotly)
require(shinyLP)
require(markdown)
require(rmarkdown)

thumbnail_label <- function(image, label, content, button_link, button_label ){
  HTML(paste0("<div class='row'>
              <div class='col-sm-14 col-md-12'>
              <div class='thumbnail'>
              <img src='", image ,"' alt='...'>
              <div class='caption'>
              <h3>", label, "</h3>
              <p>", content, "</p>
              </div>
              </div>
              </div>
              </div>") )
  
  
}

shinyUI(fluidPage(
  theme = 'bootstrap.css',
 
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
    HTML('<link rel="icon", href="map.png",
                        type="image/png" />'),
    HTML('<link rel="icon", href="people.png",
                        type="image/png" />'),
    HTML('<link rel="icon", href="data.PNG",
                        type="image/png" />'),
    HTML('<link rel="icon", href="Capture3.PNG",
                        type="image/png" />'),
    HTML('<link rel="icon", href="timeline2.PNG",
                        type="image/png" />'),
    HTML('<link rel="icon", href="people.png",
                        type="image/png" />')
  ),
  
  includeCSS('./www/bootstrap.css'),
  
  jumbotron("U.S College Campus Sexual Assaults","", button = FALSE),
  
  navbarPage("",
             tabPanel("Home",
                       panel_div(class_type = "primary", panel_title = 'About this project',
                                 content = "The purpose of this report is to inform perspective and current college students, 
                                            as well as their parents, about campus safety in terms of sexual assault. After
                                            reading this report, we hope prospective students + their parents will be able to make a more informed
                                            college decision. Additionally, we hope to raise current student awareness regarding their college’s safety,
                                            and to help them hold the colleges/universities accountable for protecting student safety."),
                                   
            headerPanel("Features:"), 
            fluidRow(
               column(width = 4, div(style = "height:0px;"), thumbnail_label(image = 'map.png', label = 'Explore by location',
                                         content = 'See the distribution of reported sexual assaults across 
                                         college campuses in the US over the last decade. Compare and contrast
                                         colleges by population, sector, and gender ratio.',
                                         button_link = '#tab-3276-2', button_label = 'Explore map')
               ),
               column(4,  div(style = "height:0px;"), thumbnail_label(image = 'timeline2.PNG', label = 'Explore mishandled cases',
                                                                      content = 'In 2015 Department of Education investigated sexual assault
                                                                      cases involving student athletes. They found 400 cases to have been mishandled.
                                                                      This graph encodes the timelines of open and closed cases.',
                                                                      button_link = NULL, button_label = 'Explore cases')
               ),
               column(4,  div(style = "height:0px;"), thumbnail_label(image = 'Capture3.PNG', label = 'Explore our solution',
                                         content = 'Whether you\'re a student or university employee, here are
                                         some ways you can do your part to help victims and prevent future attacks.',
                                         button_link = NULL, button_label = 'Get involved')
               )),

               fluidRow(
               column(4,  div(style = "height:0px;"), thumbnail_label(image = 'data.PNG', label = 'Understanding our Data',
                                                                      content = 'Learn more about where our data came from,
                                                                      and why it was collected. Also, explore our raw data
                                                                      for yourself if you want.',
                                                                      button_link = NULL, button_label = 'See more')
               ),
               column(4,  div(style = "height:0px;"), thumbnail_label(image = 'report.PNG', label = 'Explore our findings',
                                                                      content = 'Whether you\'re a student or university employee, here are
                                                                      some ways you can do your part to help protect students',
                                                                      button_link = NULL, button_label = 'Get involved')
               ),
               column(4,  div(style = "height:0px;"), thumbnail_label(image = 'people.png', label = 'Meet the Team',
                                         content = 'The INFO201 dream team: read on to see made up facts about (codenames)
                                         Alpha, Beta, Charlie, and (not a code name) Echo.', 
                                         button_label = "Meet the team", button_link = NULL)
               )
             )
             ),
             tabPanel("Sexual Assaults by Location",
                      headerPanel("Sexual Assaults by Location"),
                      
                      # year, population, public/private
                      sidebarPanel(
                        checkboxInput("include", "Include 0 counts?", value = TRUE),
                        checkboxInput("public.school", "Public", value = TRUE),
                        checkboxInput("private.school", "Private", value = TRUE),
                        sliderInput("map.year.slider", "Year:", 2005, 2015, 1, sep = ""),
                        sliderInput("map.population", "Campus Population:", 0, 80000, 1000, value = c(0, 5000), dragRange = TRUE),
                        actionButton('dog', 'Pet dog')
                      ),
                      
                      mainPanel(plotlyOutput("assaultMap"))
             ),
             tabPanel("Mishandled Sexual Assaults",
                      id = 'timeline',
                      headerPanel("As flagged by Title IX"),
                      sidebarPanel(
                        textInput("txt", "Search by school:"),
                        selectInput("oc", "Open or closed cases?", choices = list("Open", "Closed"))),
                      mainPanel(plotlyOutput("timeline"))
             ),
             tabPanel("Summary of Findings",
                      id = 'report',
                      htmlOutput('report')
             ),     
             tabPanel("About the Data",
                      includeMarkdown("aboutData.Rmd")
             ),
             tabPanel("Moving Forwards",
                      includeMarkdown("solution.Rmd")
             ),
             tabsetPanel("About us",
                      id = 'bread',
                      htmlOutput('au')
                      
            )
  ) ))
 
 