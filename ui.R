# Shiny application for the Minard data set in Histdata library
# Slide on date of Napoleon's campaign
# dates added tot the troops-set (troopsES.csv); these dates are interpolations of available dates
# dates for use of UI only, not historically validated!!
# Main source: https://en.wikipedia.org/wiki/French_invasion_of_Russia

library(shiny)
#load troopsES in UI to provide slider range
troopsES <- read.csv('troopsES.csv')
troop1 <- subset(troopsES, group == 1)
troop1$date <- as.Date(as.character(troop1$date))

shinyUI(fluidPage(

  # Title
  title = "French Invasion of Russia (1812)",
  titlePanel("Napoleon's Invasion of Russia (1812)"),
  plotOutput("marchOut"),
  # panel with slider and small plot
  fluidRow(column(4,
          h4("Select a day in the campaign (mmdd)"),
          sliderInput(
                  'myDate',
                  "",
                  min = min(troop1$date),
                  max = max(troop1$date),
                  value = mean(troop1$date),
                  timeFormat = "%m%d"),
          br(), br(),
          p("Basic idea and initial code based on Hadley Wickham's 
            recreation of the Minard plot in ggplot2"),
          p("Additional dates imputed based on dataset and Wikipedia")),
          column(7,
                 h4("Troop strength"),
                 p("Number of survivors vs date"),
                 plotOutput("plotSurvivors", height = "200px"), 
                 htmlOutput("textSurvivors", style = "color:red"),
                 offset = 1))))
