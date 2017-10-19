library(shiny)
library(tidyverse)
library(ggplot2)

bcrates_race <- read.table("data/breast_cancerrates2.txt", header = TRUE)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$race_plot <- renderPlot({
  
    breast_cancerrates2 %>%
      filter(state == input$Area) %>%
      ggplot(aes_string("Area", input$value)) + 
      geom_bar(stat = "identity")
    
  })  
}
