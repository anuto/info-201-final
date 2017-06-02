# wants: number of cases (rape), 
#         percent of cases to population (rape / pop * 1000), 
#         longitude (longitude),
#         latitude (latitude)
AssaultMap <- function(assault.data) {
  pop.percent <- (assault.data$rape / assault.data$pop) * 1000
  
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("grey85"),
    subunitcolor = toRGB("white"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  plot_geo(assault.data, 
           lat = ~latitude, 
           lon = ~longitude,
           text = ~paste(primary_city, 
                         county,
                         INSTNM,
                         paste("total cases: ", assault.data$rape),
                         paste("cases per 1000 students: ", pop.percent),
                         sep = "<br />")
           ) %>%
    add_markers(
      color = ~pop.percent,
      opacity = 0.5,
      colors = c("#000000", "#ff0000"),
      symbol = I("circle"),
      size = ~pop,
      hoverinfo = "text"
    ) %>%
    colorbar(title = "Reported Rape Cases Per Thousand Students") %>%
    layout(
      title = 'Cases of Sexual Assault per Year by Campus', geo = g
    )

}