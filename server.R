
# Server sidelogic for the DDP assignment based on the minard plot and dataset

library(shiny)

library(HistData)
library(ggplot2)
#set up of the plot based on the ggplot example by Hadley Wickham
Sys.setlocale("LC_TIME", "C") #i have a different locale, dates are in US notation
troopsES <- read.csv('troopsES.csv')
troop1 <- subset(troopsES, group == 1)
troop1$date <- as.Date(as.character(troop1$date))
startcampain <- min(troop1$date)
troop1$dic <- as.numeric(
        troop1$date-startcampain) # extra variable 'Days In Campaign- dic'

cities <- Minard.cities
cities$city <- as.character(cities$city)
xlim <- scale_x_continuous(limits = c(24, 39))

shinyServer(function(input, output) {
        fitRow <- reactive({
                selectedDIC <-
                        as.numeric(input$myDate - startcampain)
                fitDIC <- max(troop1$dic[troop1$dic <= selectedDIC])
                troop1$X[troop1$dic == fitDIC]
        })
        output$marchOut <- renderPlot({
                march <- ggplot(cities, aes(x = long, y = lat)) +
                        geom_path(aes(
                                size = survivors,
                                colour = direction,
                                group = group),
                        data = troopsES, linejoin = "mitre") +
                        geom_text(
                                aes(label = city),
                                hjust = 0,
                                vjust = 1,
                                size = 4
                        ) +
                        scale_size(range = c(1, 10)) +
                        scale_colour_manual(values = c("darkolivegreen3", "orange3")) +
                        xlim + 
                        geom_point(aes(x=troop1[fitRow(),2], 
                                       y=troop1[fitRow(),3]), 
                                   color = "red", size = 7)
                march
  })
        output$textSurvivors <- renderUI({
                line1 <- paste("At", as.character(troop1[fitRow(),7]), 
                               "Napoleon had", sep = " ")
                line2 <- paste(round(troop1[fitRow(),4]/troop1[1,4],2)*100, 
                               "% of his initial troop strength left.", 
                               sep = " ")
                HTML(paste(line1, line2, sep = ' '))
        })
        output$plotSurvivors <- renderPlot({
                ggplot(data = troop1, aes(date, survivors)) + 
                        geom_step() + 
                        geom_hline(aes(yintercept=troop1[fitRow(),4]),
                                   color = "red", size = 2)
        })

})
