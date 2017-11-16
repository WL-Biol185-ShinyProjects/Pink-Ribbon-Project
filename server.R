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

  


