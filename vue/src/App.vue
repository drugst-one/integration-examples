<template>
  <div id="app" style="display: flex">
    <div style="border: black solid 1px; margin: 15px; width: 29vw;">
      <div style="margin:15px">
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
          <input type="color" @change="setColor" value="#ffffff">
        </div>
      </div>
    </div>
    <div ref="drugstoneContainer" style="width: 70vw; min-width: 700px;">
      <network-expander id='drugstone-plugin-id' :task-id="taskId" :network='getNetwork()' :config='getConfig()'
                        :style="drugstoneStyle"
                        @taskEvent="saveTaskId"></network-expander>
    </div>
  </div>
</template>

<script>


export default {
  name: 'App',
  data() {
    return {
      network: {nodes: [{id: "pten"}, {id: "tp53"}]},
      config: {nodeShadow: "true", edgeShadow: "false", autofillEdges: "false"},
      taskIds: [],
      taskId: undefined,
      drugstoneStyle: {
        '--drgstn-panel': '#ffffff'
      }
    }
  },
  methods: {
    addNode: function () {
      let nodeId = this.$refs.nodeInput.value
      if (nodeId != null && nodeId.length > 0)
        this.network.nodes.push({id: nodeId})
      this.$refs.nodeInput.value = ""
    },

    getNetwork: function () {
      return JSON.stringify(this.network)
    },

    getConfig: function () {
      return JSON.stringify(this.config)
    },

    saveTaskId: function (event) {
      this.taskIds.push(event.detail.taskId)

    },
    loadTask: function (id) {
      this.taskId = id;
    },

    setColor: function (event) {
      this.drugstoneStyle['--drgstn-panel'] = event.target.value;
    }
  },


  components: {}

}
</script>

<style>

</style>
