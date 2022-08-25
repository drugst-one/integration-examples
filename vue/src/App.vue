<template>
  <div id="app" style="display: flex">
    <div style="border: black solid 1px; margin: 15px; width: 29vw;">
      <div style="margin:15px">
        <!-- Function Panel -->
        <h2>Functions</h2>
        <div>
          <input ref="nodeInput">
          <button @click="addNode()">Add node</button>
        </div>
        <div>
          <h3>TaskID list</h3>
          <button @click="loadTask()" style="margin: 5px">Clear TaskId</button>
          <div v-for="taskId in taskIds" :key="taskId" style="padding: 5px">
            <button @click="loadTask(taskId)">Load {{ taskId }}</button>
          </div>
        </div>
        <div>
          <h3>Panel color</h3>
          <input type="color" @change="setColor" value="#bfbfbf">
        </div>
      </div>
    </div>
    <div ref="drugstoneContainer" style="width: 70vw; min-width: 700px;">
      <!-- Loading drugst.one component with reactive attribute assignment of taskId, network, config, and style and task EventListener -->
      <drugst-one id='drugstone-plugin-id' :task-id="taskId" :network='getNetwork()' :config='getConfig()' :groups='getGroups()'
                        :style="drugstoneStyle"
                        @taskEvent="saveTaskId"></drugst-one>
    </div>
  </div>
</template>

<script>


export default {
  name: 'App',
  data() {
    return {
      // Initial network object
      network: {nodes: [{id: "pten"}, {id: "tp53"}]},
      // Initial configuration object
      config: {nodeShadow: "true", edgeShadow: "false", autofillEdges: "false"},
      // Network groups object
      groups: {nodeGroups: []},
      // List of received taskIds by the taskEvent EventHandler
      taskIds: [],
      // Current taskId
      taskId: undefined,
      // Initial drugst.one style map
      drugstoneStyle: {
        '--drgstn-panel': '#bfbfbf'
      }
    }
  },
  methods: {
    // Add node from input-field
    addNode: function () {
      let nodeId = this.$refs.nodeInput.value
      if (nodeId != null && nodeId.length > 0)
        // Add new node entry to network object
        this.network.nodes.push({id: nodeId})
      this.$refs.nodeInput.value = ""
    },

    // Network to string method for drugst.one, because raw object cannot be handed over to the plugin
    getNetwork: function () {
      return JSON.stringify(this.network)
    },

    // Groups to string method for drugst.one, because raw object cannot be handed over to the plugin
    getGroups: function () {
      return JSON.stringify(this.groups)
    },

    // Configuration to string method for drugst.one, because raw object cannot be handed over to the plugin
    getConfig: function () {
      return JSON.stringify(this.config)
    },

    // Callback of task EventListener on the drugst.one component
    saveTaskId: function (event) {
      // Saving only the taskId of the event details
      this.taskIds.push(event.detail.taskId)
    },

    // Loading taskId based on pressed button
    loadTask: function (id) {
      // Setting current taskId to the requested
      this.taskId = id;
    },

  // Set color of panel based on color-picker decision
    setColor: function (event) {
      // Set style variable for panel
      this.drugstoneStyle['--drgstn-panel'] = event.target.value;
    }
  },


  components: {}

}
</script>

<style>

</style>
