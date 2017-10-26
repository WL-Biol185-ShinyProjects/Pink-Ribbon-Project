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
                  choices = unique(breast_cancerrates2$Area)
                 ),

    selectInput(inputId = 'value',
                label = 'what_to_plot',
                choices = colnames(breast_cancerrates2)[2:ncol(breast_cancerrates2)])),
    
  #Panelplot
  mainPanel(
    plotOutput(outputId = "race_plot")
      )
    )
  )


   
  




