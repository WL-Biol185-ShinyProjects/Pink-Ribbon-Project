library(shiny)
library(tidyverse)
library(ggplot2)
library(leaflet)

read.csv("gathered_data_corrected")
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:5, na.rm= TRUE)
breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)
View(zip_codes_states)

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

function(input, output) {
    
    output$mymap <- renderLeaflet({
      zip_codes_states %>%
        na.omit(zip_codes_states) %>%
        filter(!is.na(longitude)) %>%
        filter(!is.na(latitude)) %>%
        filter(state == input$state) %>%
        arrange(county) %>%
        leaflet(data = zip_codes_states) %>% 
        setView(lng= -79.44, lat= 37.78, zoom= 20) %>%
        addTiles() %>%
        addMarkers(label = ~`Recent 5-Year Trend in Incidence Rates`, clusterOptions = markerClusterOptions())
    
    })
  }


      
    
    


  

