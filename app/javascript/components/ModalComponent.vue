<template lang="html">
    <!-- Modal -->
    <div class="modal fade" id="bsModal" tabindex="-1" role="dialog" aria-labelledby="bsModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="bsModalLabel">{{title}}</h4>
                </div>
                <div class="modal-body">
                    <p>Inicio: {{start}}</p>
                    <p>Fim: {{end}}</p>
                    <p>Sala: {{room}}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" @click="confirm">{{confirmText}}</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "ModalComponent",
        mounted () {
            this.$bus.$on('abcd', (args) => {
                this.type = args.type
                this.title = args.title
                this.start = args.start
                this.end = args.end
                this.room = args.room
                this.confirmText = args.confirmText || 'Close'

                $('#bsModal').modal('show')
            })
            $('#bsModal').on('show.bs.modal', (e) => {
            })

            $('#bsModal').on('hidden.bs.modal', (e) => {
                this.resetProperties()
            })
        },
        data () {
            return {
                type: '',
                title: '',
                start: '',
                end: '',
                room: '',
                confirmText: '',
            }
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
            }
        }
    }
</script>

<style scoped>

</style>