library(shiny)
library(tidyverse)
library(ggplot2)

bcrates_race <- read.table("breast_cancerrates2.txt", header = TRUE)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$race_plot <- renderPlot({
  
    breast_cancerrates2 %>%
      race <- filter(colnames(breast_cancerrates2)[2:ncol(breast_cancerrates2)] == input$state) %>%
      ggplot(race, aes(input$value, "Area")) + 
      geom_bar(stat = "identity")+
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
  })  
}
