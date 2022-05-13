library(shiny)
library(shinyjs)
library(jsonlite)

## Define server logic
server <- function(input, output,session) {

  network <- fromJSON('{"nodes":[{"id":"PTEN"},{"id":"TP53"}]}')
  config <- fromJSON('{}')
  
  ## Network and Config have to be in JSON format when handed to drugst.one
  networkString <- toJSON(network)
  configString <- toJSON(config)
  
  ## TaskID variable to load/unload analysis results
  taskId <- ""
  
  ## Eventlistener initialization after website rendering using JavaScript
  session$onFlushed(function(){
    ## Calling init function (www/set-color.js). Also already contains code to 
    ## render buttons and on-click actions for each incoming task-id.
    session$sendCustomMessage(type = 'init-eventhandler', message="")
  })
  
  ## Eventlistener for adding nodes to the network
  observeEvent(input$add, {
    ## Adding new node to the network object
    network$nodes <<- rbind(network$nodes, input$node)
    ## Update network JSON object
    networkString <<- toJSON(network)
  })
  
  ## Eventlistener for clearing the taskId
  observeEvent(input$clearTask,{
    taskId <<-""    
  })
  
  ## Eventlistener for panel colorpicker
  observeEvent(input$color, {
    ## Using js to globally set color '--drgstn-panel' (www/set-color.js)
    session$sendCustomMessage(type = 'panelcolor', message=input$color)
  })
  
  ## Reactive creation of the drugst.one plugin html configuration
  output$drugstone <- renderUI({
    ## Triggers for reactive rerendering
    input$add
    input$clearTask
    ## Creation of the <drugst-one> tags, including the id the DOM element
    ## can be called by, the variable taskId to change the shown analysis
    ## result, the configuration and the network JSON strings.
    HTML(paste('<drugst-one
                   id="drugstone-component-id"',
               'task-id="',taskId,'"
                   config=',configString,'
                   network=', networkString,'></drugst-one>',sep=""))
    }
  )
}

## Webpage composition
ui <- fluidPage(
    ## Loading of js code used for eventlistening, button creation and color
    ## setting
    tags$head(tags$script(src = "set-color.js")),
    tags$head(tags$script(src = "task-listener.js")),
    
    ## Loading drugst.one plugin files
    tags$head(HTML('<script src="https://cdn.drugst.one/latest/drugstone.js"></script>')),
    tags$head(HTML('<link rel="stylesheet" href="https://cdn.drugst.one/latest/styles.css">')),
    
    ## Initial setting of a drugst.one color css variable
    tags$head(tags$style(":root {--drgstn-panel:#ccccff;}")),
  
    ## Function panel
    HTML('<div style="display: flex">
    <div style="border: black solid 1px; margin: 15px; width: 29vw;">
      <div style="margin:15px">
            <h2>Functions</h2>
             '),
    actionButton("add", "add Node"),
    textInput("node", "enter node", value=""),
    colourInput("color","Select panel Background color",value="#ccccff"), 
    actionButton("clearTask", "clear TaskID"),HTML('<div id="button-container"></div></div>
        </div>
    </div>
    <div style="width: 70vw; min-width: 700px;">'),
  
    ## Adding the reactive drugst.one UI-Component
    uiOutput("drugstone"),
    HTML('</div></div>')
)




## Start app
shinyApp(ui = ui, server = server)
