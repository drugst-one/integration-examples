######################################################
## minimal working example - direct integration 
##
## 2021-08-10, MW
######################################################

library(shiny)
library(jsonlite)

config <- '{}'
network <- fromJSON('{"nodes":[{"id":"PTEN"},{"id":"TP53"}]}')

ui <- fluidPage(

      
      tags$head(HTML('<script src="https://drugst.one/cdn/nightly/dock1/drugsTone.js"></script>')),
      tags$head(HTML('<link rel="stylesheet" href="https://drugst.one/cdn/nightly/dock1/styles.css">')),

    
    HTML('<div style="display: flex">
    <div style="border: black solid 1px; margin: 15px; width: 29vw;">
      <div style="margin:15px">
            <h2>Functions</h2>
             <div>
                <input id="nodeInput">
                <button id="addNode">Add node</button>
            </div>
        </div>
    </div>
    <div style="width: 70vw; min-width: 700px;">
          <network-expander
                   id="example-drugst.one"
                   config=',config,'
                   network=',toJSON(network),'>
          </network-expander>
         </div></div>')
)


## Define server logic
server <- function(input, output) {

}

## Start app
shinyApp(ui = ui, server = server)