library(shiny)
library(tidyverse)
library(ggplot2)

bcrates_race <- read.table("breast_cancerrates2.txt", header = TRUE)
gathered_data <- gather(breast_cancerrates2,  key = "race", value = "incidence", 2:5, na.rm = FALSE)


# Define server logic required to draw a histogram
function(input, output) {
  
  output$race_plot <- renderPlot({
  
    breast_cancerrates2 %>%
      filter("Area" == input$state) %>%
      ggplot(aes(Race, Incidence)) + 
      geom_bar(stat = "identity")
      
  })  
}
