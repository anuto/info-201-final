require(shiny)
require(plotly)
require(plyr)
require(dplyr)
require(stringi)
require(shinyLP)
require(knitr)
require(gdata)

shinyServer(function(input, output, session) {

  output$assaultMap <- renderPlotly({
    source('./scripts/map.R')

    assault.map.data <- read.csv("./data/full.map.data.csv", stringsAsFactors = FALSE)
    school <- ""
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
    
    zero.filter <- -1
    if (!input$include) {
      zero.filter <- 0
    }

    # select only the data specified in maps of the year/population size/rank specified here
    if (year == 5 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL5, rape = RAPE5) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), 
                          pop < max, 
                          pop > min,
                          rape > zero.filter))
    } else if (year == 5 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL5, rape = RAPE5) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 6 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL6, rape = RAPE6) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 6 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL6, rape = RAPE6) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 7 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL7, rape = RAPE7) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 7 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL7, rape = RAPE7) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 8 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL8, rape = RAPE8) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 8 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL8, rape = RAPE8) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 9 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL9, rape = RAPE9) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 9 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL9, rape = RAPE9) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 10 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL10, rape = RAPE10) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 10 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL10, rape = RAPE10) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 11 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL11, rape = RAPE11) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 11 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL11, rape = RAPE11) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 12 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL12, rape = RAPE12) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 12 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL12, rape = RAPE12) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 13 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL13, rape = RAPE13) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 13 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL13, rape = RAPE13) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 14 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL14, rape = RAPE14) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 14 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL14, rape = RAPE14) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
      
    } else if (year == 15 && school == "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL15, rape = RAPE15) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(grepl(public.school, assault.map.data$sector_desc.x),
                          grepl(private.school, assault.map.data$sector_desc.x), pop < max, pop > min,
                          rape > zero.filter))
    } else if (year == 15 && school != "") {
      AssaultMap(assault.map.data %>%
                   mutate(pop = TOTAL15, rape = RAPE15) %>% 
                   select(pop, rape, latitude, longitude, INSTNM, primary_city, county) %>%
                   filter(INSTNM == school,
                          rape > zero.filter))
    }

  })
  
  output$timeline <- renderPlotly ({
    source('./scripts/timeline.R')
    df <- read.csv('./data/title.ix.cases.csv')
    if (input$txt != "") {
      df <- df %>% filter(college == input$txt)
    }
    
    Timeline(input$oc, df)
  })
  
  observeEvent(input$dog, {
               updateNavbarPage(session, 'bread')
         
  })
  
  output$au <- renderUI(includeHTML('aboutus.html'))
  
  output$report <- renderUI(includeHTML('index.html'))
  

})