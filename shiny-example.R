install.packages("shiny")
library(shiny)

## interface
ui = fluidPage(
    h1("Exemple de Shiny App"),
    h2("Conversor de Celsius a Farenheit")
)

## server
server = function(
    ### TODO
)

## execution
shinyApp(
    ui, 
    server,
    options = list( ### list to configure port
        port = 5551 
    )
)


