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

  


