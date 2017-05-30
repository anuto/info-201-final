# map :D

# I want: number of cases (rape), 
#         percent of cases to population (rape / pop * 1000), 
#         longitude (longitude),
#         latitude (latitude)
#         :D
AssaultMap <- function(assault.data) {
  pop.percent <- (assault.data$rape / assault.data$pop) * 1000
  
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("black"),
    subunitcolor = toRGB("white"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  plot_geo(assault.data, lat = ~latitude, lon = ~longitude) %>%
    add_markers(
      text = ~paste(primary_city, 
                    county,
                    paste("total cases: ", assault.data$rape),
                    paste("cases per 1000 students: ", pop.percent),
              sep = "<br />"),
      color = ~rape,
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