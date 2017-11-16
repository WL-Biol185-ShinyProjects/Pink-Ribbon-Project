library(shiny)


fluidPage(
  
  # Application title
  titlePanel("Deaths Per 100,000 Due to Breast Cancer By State and Ethnicity in 2014"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'Area', 
                  label = 'Select an Area',
                  choices = sort(unique(gathered_death$Area)),
                  selected = 1
                  
                   )
              ),
    
#Panelplot
mainPanel(
  plotOutput(outputId = "DeathPlot")

    )
  )
    
)



  


   
  




