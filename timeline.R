library(plotly)
library(gdata)
library(dplyr)
# Read data
title.ix.data <- read.csv('./data/title.ix.cases.csv')
# Read still open case data
open <- title.ix.data %>% filter(is.closed == "FALSE")
# Set the date into the form that is usable.
open.case <- as.Date(open$opened, format = "%m/%d/%y")
# Read closed case data
close <- title.ix.data %>% filter(is.closed == "TRUE") %>% select(case_id, opened, closed)
# Set the open date int othe form that is usable
closed.case.open.date <- as.Date(close$opened, format = "%m/%d/%y")
# Set the close date int othe form that is usable
closed.case.close.date <- as.Date(close$closed, format = "%m/%d/%y")
# Calculate the days that take for each closed case.
duration <- closed.case.close.date - closed.case.open.date


# Create a variable that hides for the axis.
hide.axis <- list(
  title = "",
  zeroline = FALSE,
  showline = FALSE,
  showticklabels = FALSE,
  showgrid = FALSE
)


# Draw the timeline plot for open cases
open.case.timeline <- plot_ly(x = ~open.case, y = 0) %>%
  layout(yaxis = ax, xaxis = list(title = 'Still Open Cases Timeline'))

# Draw the timeline plot for closed cases
close.case.timeline <- plot_ly(x = ~closed.case.open.date, y = 0,
                               text = paste(duration, "days"), color = 'orange',
                               hoverinfo = 'text',
                               text = 'abc') %>% 
  layout(yaxis = ax, xaxis = list(title = 'Closed Cases Timeline'))

# Draw the duration plot for the closed cases
duration.graph <- plot_ly(x = ~closed.case.open.date, y = ~duration, type = "scatter", mode = 'lines',
                          text = paste(duration, "days")) %>% 
  layout(title = "Closed Case Duration Graph", xaxis = list(title = 'Closed Cases Date'),
         yaxis = list(title = 'Days to close case'))
