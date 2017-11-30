library(shiny)
library(tidyverse)
library(ggplot2)


read_xlsx("death.xlsx")
gathered_death <- gather(death, key = "Race", value = "Deaths", 2:5, na.rm= TRUE)



# Define server logic required to draw a histogram
function(input, output) {
  
  output$DeathPlot <- renderPlot({

    gathered_death %>%
      filter(gathered_death$Area == input$Area) %>%
      ggplot(aes(Race, Deaths, fill = Race)) + geom_histogram(stat = "identity")
    
  })   
}


#Server for map by county
function(input, output) {
    
    points <- eventReactive(input$recalc)
    # Reactive expression for the data subsetted to what the user selected
    points() <- reactive({
      breastcancer_bycounty_edited2$Average Annual Count >= input$range[1] & quakes$mag <= input$range[2]
    })
    
    output$mymap <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        setView(lng= -79.44, lat= 37.78, zoom= 3) %>%
        addProviderTiles(providers$OpenStreetMap)
                         leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18)) %>%
        addMarkers(lng= 174.768, lat=-36.852, popup="The birthplace of R")
    })
  }




  
