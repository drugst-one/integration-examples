Shiny.addCustomMessageHandler("init-eventhandler",
	function(message){
		document.getElementById("drugstone-component-id").addEventListener("taskEvent",
			function(event){
				let id = event.detail.taskId;
		                let container = document.getElementById("button-container")
                		let btn = document.createElement("button")
                		btn.innerHTML = "Load "+id;
                		btn.onclick= function(){
                        		document.getElementById("drugstone-component-id").setAttribute("task-id",id)
                		}
                		container.appendChild(btn)
        		}

		
		)
	}
)
