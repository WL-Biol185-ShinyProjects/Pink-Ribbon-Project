library(shiny)
library(tidyverse)
library(ggplot2)

breast_cancerrates2 <- read.table("breast_cancerrates2.txt", header= TRUE)
gathered_data <- gather(breast_cancerrates2, key = "Race", value = "Incidence", 2:5, na.rm= FALSE)


# Define server logic required to draw a histogram
function(input, output) {
  
  output$race_plot <- renderPlot({
  
    gathered_data %>%
      filter("Area" == input$state) %>%
      ggplot(aes(Race, Incidence)) + 
      geom_bar(stat = "identity")+
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

  


