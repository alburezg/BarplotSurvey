# BarplotSurvey app.R
rm(list = ls())


# Libraries
library(survey)
library(shiny)

# Get data and function
source("https://raw.githubusercontent.com/javob/BarplotSurvey/master/data/PrepareData.R", encoding = "UTF-8")
source("https://raw.githubusercontent.com/javob/BarplotSurvey/master/data/BarplotSurvey.R", encoding = "UTF-8")


ui <- fluidPage(
  headerPanel('Cultura Democrática en Guatemala'),
  sidebarPanel(
    selectInput("variable", "Variable:",
                dataQuestions3),
    checkboxGroupInput("q1", "Género:",
                       c("Hombre" = "1","Mujer" = "2"),
                       c(1:2)),
    checkboxGroupInput("ur", "Población:",
                       c("Urbano" = "1","Rural" = "2"),
                       c(1:2)),
    checkboxGroupInput("etid", "Étnia:",
                       c("Mestizo" = "1","Indígena" = "2","Otra" = "3"),
                       c(1:3)),
    checkboxGroupInput("q2", "Edad:",
                       c("De 18 a 25" = "1","De 26 a 35" = "2",
                         "De 36 a 47" = "3","De 48 a 91" = "4"),
                       c(1:4))
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function(input, output) {

  selectedData <- reactive({
    list(q2 = as.numeric(input$q2[1:4]),
         q1 = as.numeric(input$q1[1:2]),
         etid = as.numeric(input$etid[1:3]),
         ur = as.numeric(input$ur[1:2]))
  })
  
  mainVar <- reactive({
    dataVars[as.numeric(strsplit(input$variable, "\\.")[[1]][1])]
  })
  
  output$plot1 <- renderPlot({
    BarplotSurvey(variable = mainVar(), 
                  selected = selectedData())
  })

}


shinyApp(ui = ui, server = server)
