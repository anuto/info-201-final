library(plotly)
library(gdata)
library(dplyr)

Timeline <- function(oc) {
  
  # Read data
  data <- read.csv('./data/title.ix.cases.csv')
  # Read still open case data
  open <- data %>% filter(is.closed == "FALSE")
  # Set the date into the form that is usable.
  open.case <- as.Date(open$opened, format = "%m/%d/%y")
  # Read closed case data
  close <- data %>% filter(is.closed == "TRUE") %>% select(case_id, opened, closed)
  # Set the open date int othe form that is usable
  closed.case.open.date <- as.Date(close$opened, format = "%m/%d/%y")
  # Set the close date int othe form that is usable
  closed.case.close.date <- as.Date(close$closed, format = "%m/%d/%y")
  # Calculate the days that take for each closed case.
  duration <- closed.case.close.date - closed.case.open.date
  
  
  # Create a variable that hides for the axis.
  ax <- list(
    title = "",
    zeroline = FALSE,
    showline = FALSE,
    showticklabels = FALSE,
    showgrid = FALSE
  )
  
  
  # Draw the timeline plot for open cases
  if(oc == "Open") {
    p <- plot_ly(x = ~open.case, y = 0, color = 'blue') %>% layout(yaxis = ax)
  } else{
  # Draw the timeline plot for closed cases
  g <- plot_ly(x = ~closed.case.open.date, y = 0, text = paste(duration, "days"), color = 'orange') %>% 
    layout(yaxis = ax)
  }
}