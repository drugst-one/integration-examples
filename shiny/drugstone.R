######################################################
## minimal working example - direct integration 
##
## 2021-08-10, MW
######################################################

library(shiny)
library(jsonlite)

config <- '{}'
network <- fromJSON('{"nodes":[{"id":"PTEN"},{"id":"TP53"}]}')

nodeInput = textInput("node", "enter node", value="")

## Define server logic
server <- function(input, output,session) {
  observeEvent(input$addNode, {
    #        network$nodes <- rbind(network$nodes, input$node)
    #        input$node = ""
  })
  
  output$drugstone <- renderUI({
    HTML(paste('<network-expander
                   id="example-drugst.one"
                   config=',config,'
                   network='), toJSON(network), HTML('>
                     </network-expander>'))
  })
}

ui <- fluidPage(

      
      tags$head(HTML('<script src="https://drugst.one/cdn/nightly/dock1/drugsTone.js"></script>')),
      tags$head(HTML('<link rel="stylesheet" href="https://drugst.one/cdn/nightly/dock1/styles.css">')),

    
    HTML('<div style="display: flex">
    <div style="border: black solid 1px; margin: 15px; width: 29vw;">
      <div style="margin:15px">
            <h2>Functions</h2>
             <div><button id="addNodes" class="shiny-bound-input action-button">Add Node</button>'),nodeInput,
    HTML('</div>
        </div>
    </div>
    <div style="width: 70vw; min-width: 700px;">'),htmlOutput("drugstone"),
    HTML('</div></div>')
)




## Start app
shinyApp(ui = ui, server = server)