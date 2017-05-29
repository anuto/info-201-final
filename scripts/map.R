# map :D

# temporary data finding
# assault.data <- read.csv("./data/title.ix.cases.csv", stringsAsFactors = FALSE)

# I want: number of cases (count), 
#         percent of cases to population (pop.percent), 
#         longitude (long),
#         latitude (lat)
#         :D

assault.map <- function(assault.data) {

  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("black"),
    subunitcolor = toRGB("white"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  plot_geo(assault.data, lat = ~lat, lon = ~long) %>%
    add_markers(
      text = ~paste(date, 
                    city, 
                    paste("total cases: ", count),
                    paste("cases per 100 students: ", pop.percent), 
              sep = "<br />"),
      color = ~unclosed.ratio, 
      colors = c("#ffffff", "#ff0000"),
      symbol = I("circle"), 
      size = ~pop.percent, 
      hoverinfo = "text"
    ) %>%
    colorbar(title = "Cases per 100 Students") %>%
    layout(
      title = 'Cases of Sexual Assault per Year by Campus', geo = g
    )

}