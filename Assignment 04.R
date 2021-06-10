
library(shiny)
library(tidyverse)

# Data Connection and Renaming Column ----

TestResultData <- read_csv("MathTestResults.csv") %>%
  rename(
    LevelOnePercent = "Level 1 %"
  )

# Define UI for level 1 scores app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Level 1 Math Test Results Obtained in New York State"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for variable to plot against level 1 test results ----
      selectInput("variable", "Variable:",
                  c("Grade" = "Grade",
                    "Year" = "Year",
                    "Category" = "Category")),
      
      # Input: Checkbox for whether outliers should be included ----
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Description ----
      h5("This app allows us to investigate the New York State Mathematics Tests results from 
      years 2006 to 2011. Here we are specifically interested in understanding the percent
      of students that obtained a Level 1 test result, and further explore the results by
      observing by grade level, year and category of student."),
      
      # Data set location ----
      h5("To view the complete dataset, you can visit the following link:
         https://catalog.data.gov/dataset/2006-2011-nys-math-test-results-by-grade-citywide-by-race-ethnicity"),
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against level 1 test results ----
      plotOutput("testPlot")
      
    )
  )
)

# Define server logic to plot various variables against level 1 test results ----
server <- function(input, output) {
  
  # Compute the formula text ----
  formulaText <- reactive({
    paste("LevelOnePercent ~", input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against level 1 test results ----
  # and only exclude outliers if requested
  output$testPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = TestResultData,
            outline = input$outliers,
            col = "#75AADB", pch = 19,
            ylab = "Percentage of Level 1 Test Results")
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)