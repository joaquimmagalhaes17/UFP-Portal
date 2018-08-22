<template lang="html">
  <!-- Modal -->
  <div 
    id="bsModal" 
    class="modal fade" 
    tabindex="-1" 
    role="dialog" 
    aria-labelledby="bsModalLabel" 
    data-toggle="modal" 
    data-backdrop="static" 
    data-keyboard="false">
    <div 
      class="modal-dialog" 
      role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button 
            type="button" 
            class="close" 
            data-dismiss="modal" 
            aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 
            id="bsModalLabel" 
            class="modal-title">{{ title }}</h4>
        </div>
        <div class="modal-body">
          <p>Inicio: {{ start }}</p>
          <p>Fim: {{ end }}</p>
          <p>Sala: {{ room }}</p>
          <p>Curso: {{ course }}</p>
          <p>Tipologia: {{ type }}</p>
          <p>Responsavel: {{ responsable }}</p>
        </div>
        <div class="modal-footer">
          <button 
            type="button" 
            class="btn btn-primary" 
            @click="confirm">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
    import moment from 'moment'
    export default {
        name: "ModalComponent",
        data () {
            return {
                title: '',
                start: '',
                end: '',
                room: '',
                type: '',
                course: '',
                responsable: '',
                confirmText: 'Close'
            }
        },
        mounted () {
            this.$bus.$on('open-modal', (args) => {
                this.title = args.details['curricular_unit']
                this.start = this.timeFormat(args.start)
                this.end = this.timeFormat(args.end)
                this.room = args.details.room
                this.type = args.details.type
                this.responsable = args.details.responsable
                this.course = args.details.course
                $('#bsModal').modal('show')
            })

            $('#bsModal').on('show.bs.modal', (e) => {})

            $('#bsModal').on('hidden.bs.modal', (e) => {
                this.resetProperties()
            })
        },
        methods: {
            confirm: function () {
                $('#bsModal').modal('hide')
            },
            resetProperties: function () {
                this.type = ''
                this.title = ''
                this.start = ''
                this.end = ''
                this.room = ''
                this.confirmText = ''
            },
            dateTimeFormat(timestamp) {
                return moment(timestamp).format("YYYY-MM-DD HH:mm")
            },
            timeFormat(timestamp) {
                return moment(timestamp).format("HH:mm")
            }
        }
    }
</script>

<style scoped>

</style>