import {Component, ElementRef, ViewChild} from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'angular';

  @ViewChild("nodeInput",{static: false}) nodeInputEl: ElementRef | undefined =undefined;
  @ViewChild("drugstoneComponent") drugstoneEl : ElementRef | undefined = undefined;


  network = {nodes: [{id: "pten"}, {id: "tp53"}]};
  config = {nodeShadow: "true", edgeShadow: "false", autofillEdges: "false"};
  taskIds = [];
  taskId:string| undefined =undefined;

  addNode(nodeId: undefined | string) {
    if (nodeId != null && nodeId.length > 0)
      this.network.nodes.push({id: nodeId})
    // @ts-ignore
    this.nodeInputEl.value = ""
  }

  getNetwork() {
    return JSON.stringify(this.network)
  }

  getConfig() {
    return JSON.stringify(this.config)
  }

  saveTaskId(event:object) {
    console.log(event)
    // @ts-ignore
    this.taskIds.push(event.detail.taskId)
    console.log(this.taskIds)

  }

  loadTask(id:string|undefined) {
    this.taskId = id;
  }

  setColor(event:object) {
    // @ts-ignore
    this.drugstoneEl?.nativeElement.style.setProperty('--drgstn-panel',event.target.value)
  }

}
