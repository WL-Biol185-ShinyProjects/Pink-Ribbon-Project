library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Breast Cancer By State and Ethnicity"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'state', 
                  label = 'Select a State',
                  choices = unique(gathered_data$Area)
                 )
    ),
    
  
  #Panelplot
  mainPanel(
    plotOutput(outputId = "race_plot")
      )
    )
  )


   
  




