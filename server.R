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

  


