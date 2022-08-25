import {Component, ElementRef, ViewChild} from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'angular';

  @ViewChild("nodeInput",{static: false}) nodeInputEl: ElementRef | undefined =undefined;
  // Getting DOM element of drugst.one component
  @ViewChild("drugstoneComponent") drugstoneEl : ElementRef | undefined = undefined;

  // Initial network object
  network = {nodes: [{id: "pten"}, {id: "tp53"}]};
  // Initial configuration object
  config = {nodeShadow: "true", edgeShadow: "false", autofillEdges: "false"};
  // Styling of network groups
  groups = {'nodeGroups':{}}
  // List of received taskIds
  taskIds = [];
  // currently loaded taskId
  taskId:string| undefined =undefined;

  // Adding node from input-field
  addNode(nodeId: undefined | string) {
    if (nodeId != null && nodeId.length > 0)
      // Add node to current network object
      this.network.nodes.push({id: nodeId})
    // @ts-ignore
    this.nodeInputEl.value = ""
  }

  // Network to string method for drugst.one, because raw object cannot be handed over to the plugin
  getNetwork() {
    return JSON.stringify(this.network)
  }

  // Configuration to string method for drugst.one, because raw object cannot be handed over to the plugin
  getConfig() {
    return JSON.stringify(this.config)
  }

  // Groups to string method for drugst.one, because raw object cannot be handed over to the plugin
  getGroups() {
    return JSON.stringify(this.groups)
  }


  // Callback of task EventListener on the drugst.one component
  saveTaskId(event:object) {
    // @ts-ignore
    // Saving only the taskId of the event details
    this.taskIds.push(event.detail.taskId)
  }

  // Loading taskId based on pressed button
  loadTask(id:string|undefined) {
    // Setting current taskId to the requested
    this.taskId = id;
  }

 // Set color of panel based on color-picker decision
  setColor(event:object) {
    // @ts-ignore
    // Set global css variable for panel color
    this.drugstoneEl?.nativeElement.style.setProperty('--drgstn-panel',event.target.value)
  }
}
