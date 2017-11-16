library(shiny)
library(tidyverse)
library(ggplot2)


read.csv("gathered_data_corrected")
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:4, na.rm= TRUE)
breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)


# Define server logic required to draw a histogram
function(input, output) {
  
  output$RacePlot <- renderPlot({
  

    gathered_data %>%
      filter(Area == input$State) %>%
      arrange(Incidence) %>%
      mutate(Race = factor(Race, levels = Race, ordered = TRUE)) %>%
      ggplot(aes(Race, Incidence, fill = Race)) + 
      geom_bar(stat = 'identity') + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1))

  })  
  }


#Server for map by county
<<<<<<< HEAD
function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
  
  points <- breastcancer_bycounty_edited$County
  
  
  output$bcmap <- renderLeaflet({
    leaflet() %>%
      setView(lng = -79.442778, lat = 37.783889, zoom = 5) %>% 
      addTiles()
  })
  observe({
    
    
    
  })
  
  
  
  
  })
}
=======
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
>>>>>>> b517e0998da9e19f6b54fd1dda382db9e584ab2d


      
    
    


  

