Assignment Developing Data Products

For the Coursera course DevelopingDataProducts the assignment is to
create an interactive diagram using Shiny,
publish this on shinyapps.io
create a github repo with the code (this repo) and
make a 5 slide wrap-up using slidify This repo contains the R-code I used for creating a plot using the Minard data set
Minard Data set

Hadley Wickham recreated the famous Minard plot of Napoleon's campaign in Russia (1812). 
I used the data from het HistData package and adapted the code by Hadley to create an interactive version. 
User's can pick a date during the campaign using a slider, 
the code then changes the two plots, on the map the position of the troops are shown, 
the other plot shows how many troops 'survived' till that day (rapily declining numbers).

Some dates were added

The dataset originally only has dates for the retreat (in the temp table). 
For proper operation of the slider I have looked up some dates from the 'advance' periode wikipedia, 
and imputed other dates. I have bound the dates to the troop-table (troopsES.csv) which is used in the shiny app
