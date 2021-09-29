Shiny.addCustomMessageHandler("init-eventhandler",
	function(message){
		document.getElementById("drugstone-component-id").addEventListener("taskEvent",function(event){Shiny.setInputValue("newTask",event.detail.taskId)})
	}
)
	
