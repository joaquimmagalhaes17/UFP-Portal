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
        <div class="modal-body" v-if="isExam">
          <p>Inicio: {{ exam.start }}</p>
          <p>Fim: {{ exam.end }}</p>
          <p>Sala: {{ exam.room }}</p>
          <p>Curso: {{ exam.course }}</p>
          <p>Tipologia: {{ exam.type }}</p>
          <p>Responsavel: {{ exam.responsable }}</p>
        </div>
        <div class="modal-body" v-if="!isExam">
          <p>Inicio: {{ class_details.start }}</p>
          <p>Fim: {{ class_details.end }}</p>
          <p>Sala: {{ class_details.room }}</p>
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
                exam: {
                    start: '',
                    end: '',
                    room: '',
                    type: '',
                    course: '',
                    responsable: '',
                    confirmText: 'Close'
                },
                class_details: {
                    start: '',
                    end: '',
                    room: '',
                },
                isExam: false
            }
        },
        mounted () {
            this.$bus.$on('open-modal', (args) => {
                if (args.color === "green") {
                    this.parseClassDetails(args)
                } else {
                  this.parseExamDetails(args)
                }

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
            },
            parseExamDetails(details) {
                this.isExam = true
                this.title = details.details['curricular_unit'];
                this.exam.start = this.timeFormat(details.start);
                this.exam.end = this.timeFormat(details.end);
                this.exam.room = details.details.room;
                this.exam.type = details.details.type;
                this.exam.responsable = details.details.responsable;
                this.exam.course = details.details.course;
            },
            parseClassDetails(details) {
                this.isExam = false;
                this.title = `${details.details['curricular_unit']} (${details.details.type})`;
                this.class_details.start = this.timeFormat(details.start);
                this.class_details.end = this.timeFormat(details.end);
                this.class_details.room = details.details.room;
            }
        }
    }
</script>

<style scoped>

</style>