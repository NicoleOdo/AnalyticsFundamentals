library(shiny)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(scales)
library(dplyr) 

# Data Connection and Renaming Column

WorkSafeNB <- read_csv("WorkSafeNB Data.csv")


# Use a fluid Bootstrap layout
fluidPage(    
  
  # Give the page a title
  titlePanel("WorkSafe New Brunswick Claims Data"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("sector_desc", "Sector:", 
                  choices = c("Construction", "Manufacturing")),
  
    # Create a spot for the barplot
    mainPanel(
      plotOutput("claimPlot")  
    )
    
  )
)
