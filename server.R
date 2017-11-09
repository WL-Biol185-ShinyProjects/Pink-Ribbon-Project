library(shiny)
library(tidyverse)
library(ggplot2)


read.csv("gathered_data_corrected")
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:5, na.rm= TRUE)
breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)


# Define server logic required to draw a histogram
function(input, output) {
  
  output$RacePlot <- renderPlot({
  

    gathered_data %>%
      filter(Race == c("All", "White", "Black", "Hispanic")) %>%
      arrange(Incidence) %>%
      mutate(Race = factor(Race, levels = Race, ordered = TRUE)) %>%
      ggplot(aes(Race, Incidence, color = Area)) + 
      geom_bar(stat = 'identity') + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1))

  })  
  }

#Server for map by county
function(input, output) {
  points <- breastcancer_bycounty_edited$County
  
  
  output$bcmap <- renderLeaflet({
    breastcancer_bycounty_edited %>%
    leaflet() %>%
      addProviderTiles(providers$OpenStreetMap)
                       options = providerTileOptions(noWrap = TRUE) %>%
                       addMarkers(lng= 39.8283, lat=98.5795, popup="Center of US")
  
  
  
  
  })
}

  


