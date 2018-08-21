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
                        <full-calendar ref="calendar" :config="config" :events="events" @event-selected="eventSelected"
                                       :editable="false"></full-calendar>
                    </div>
                </div>
            </section>
        </div>
    </div>
</template>

<script>
    import {FullCalendar} from 'vue-full-calendar'
    import 'fullcalendar/dist/locale/pt'

    export default {
        name: "IndexComponent",
        components: {
            FullCalendar
        },
        data() {
            return {
                events: [],
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
                this.$bus.$emit('open-modal', event)
            }
        },
        beforeMount() {
            axios.get('/api/calendar').then(response => {
                this.events = response.data
            })
        }
    }
</script>

<style scoped>

</style>