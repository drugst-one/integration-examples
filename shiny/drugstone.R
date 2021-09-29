######################################################
## minimal working example - direct integration 
##
## 2021-08-10, MW
######################################################

library(shiny)
library(shinyjs)
library(jsonlite)
library(colourpicker)

## Define server logic
server <- function(input, output,session) {

  network <- fromJSON('{"nodes":[{"id":"PTEN"},{"id":"TP53"}]}')
  config <- fromJSON('{}')
  networkString <- toJSON(network)
  configString <- toJSON(config)
  lastTaskId <- ""
  taskId <- ""
  
  session$onFlushed(function(){
    session$sendCustomMessage(type = 'init-eventhandler', message="")
  })
  
  observeEvent(input$add, {
    network$nodes <<- rbind(network$nodes, input$node)
    networkString <<- toJSON(network)
  })
  
  observeEvent(input$newTask,{
    lastTaskId <<- input$newTask
    insertUI(selector="#taskButtons",where="beforeEnd",actionButton("openTask", paste("Load last task")))
  })
  
  observeEvent(input$clearTask,{
    taskId <<-""    
  })
  
  observeEvent(input$openTask,ignoreInit = TRUE,  {
    taskId <<-lastTaskId
  })
  
  observeEvent(input$color, {
    session$sendCustomMessage(type = 'panelcolor', message=input$color)
  })
  
  output$drugstone <- renderUI({
    input$add
    input$openTask
    drugstoneComp <- paste('<network-expander
                   id="drugstone-component-id"',
                           'task-id="',taskId,'"
                   config=',configString,'
                   network=', networkString,'></network-expander>',sep="")
    HTML(drugstoneComp)
    }
  )
}

ui <- fluidPage(
      tags$head(tags$script(src = "message-handler.js")),
      tags$head(tags$script(src = "set-color.js")),
      tags$head(tags$script(src = "task-listener.js")),
      tags$head(HTML('<script src="https://drugst.one/cdn/nightly/dock1/drugsTone.js"></script>')),
      tags$head(HTML('<link rel="stylesheet" href="https://drugst.one/cdn/nightly/dock1/styles.css">')),
      tags$head(tags$style(":root {--drgstn-panel:#ccccff;}")),
    HTML('<div style="display: flex">
    <div style="border: black solid 1px; margin: 15px; width: 29vw;">
      <div style="margin:15px">
            <h2>Functions</h2>
             '),actionButton("add", "add Node"),textInput("node", "enter node", value=""),
    colourInput("color","Select panel Background color",value="#ccccff"), actionButton("clearTask", "clear TaskID"),HTML('<div id="taskButtons"></div>'),
    HTML('</div>
        </div>
    </div>
    <div style="width: 70vw; min-width: 700px;">'),uiOutput("drugstone"),
    HTML('</div></div>')
)




## Start app
shinyApp(ui = ui, server = server)
