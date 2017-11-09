library(shiny)


fluidPage(
  
  # Application title
  titlePanel("Breast Cancer By State and Ethnicity"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'State', 
                  label = 'Select a State',
                  choices = sort(unique(gathered_data$Area)),
                  selected = 1
                   )
              ),
    
#Panelplot
mainPanel(
  plotOutput(outputId = "RacePlot")

    )
  )
)



  


   
  




