<template>
    <div id="content-wrap" class="content-wrapper" style="min-height: 926px;">
        <div>
            <section class="content-header">
                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                    <li class="active">Dashboard</li>
                </ol>
            </section>
            <section class="content">
                <div class="row">
                    <div class="col-md-9">
                        <h2>Calendário</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <full-calendar ref="calendar" :config="config" :events="events" @event-selected="eventSelected" :editable="false"></full-calendar>
                    </div>
                </div>
            </section>
        </div>
    </div>
</template>

<script>
    import {FullCalendar} from 'vue-full-calendar'
    import 'fullcalendar/dist/locale/pt'
    import moment from 'moment'

    export default {
        name: "IndexComponent",
        components: {
            FullCalendar
        },
        data() {
            return {
                events: [
                    {
                        title: 'Algoritmos e Estruturas de Dados II - TP',
                        start: '2018-08-20T18:00:00',
                        end: '2018-08-20T20:00:00',
                        allDay: false,
                    },
                    {
                        title: 'Algoritmos e Estruturas de Dados II - TP',
                        start: '2018-08-21T18:00:00',
                        end: '2018-08-21T20:00:00',
                        allDay: false,
                    },
                    {
                        title: 'Multimédia II - TP',
                        start: '2018-08-22T20:00:00',
                        end: '2018-08-22T22:00:00',
                        allDay: false,
                    },
                    {
                        title: 'Matemática II - TP',
                        start: '2018-08-23T20:00:00',
                        end: '2018-08-23T22:00:00',
                        allDay: false,
                    },
                    {
                        title: 'Exame Matemática II',
                        start: '2018-08-24T20:00:00',
                        end: '2018-08-24T22:00:00',
                        allDay: false,
                        color: 'red'
                    },
                ],
                config: {
                    locale: 'pt',
                    buttonText: {
                        today: 'Hoje',
                        month: 'Mês',
                        week: 'Semana',
                        day: 'Dia',
                        list: 'Lista'
                    },
                    header: {
                        left: 'prev,next',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay,listWeek'
                    },
                    minTime: '08:00:00',
                    maxTime: '23:00:00',
                    height: 'auto',
                    weekends: false
                }
            }
        },
        methods: {
            eventSelected(event, jsEvent, view) {
                this.$bus.$emit('abcd', {
                    title: event.title,
                    start: this.timeFormat(event.start),
                    end: this.timeFormat(event.end),
                    room: '104',
                    type: 'modal-primary',
                    confirmText: 'Close'
                })
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