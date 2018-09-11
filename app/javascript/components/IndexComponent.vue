<template>
  <div 
    id="content-wrap" 
    class="content-wrapper" 
    style="min-height: 926px;">
    <div>
      <section class="content-header">
        <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-dashboard"/> Home</a></li>
          <li class="active">Dashboard</li>
        </ol>
      </section>
      <section class="content">
        <div class="row">
          <div class="col-md-9">
            <h2>{{ $t("index.header") }}</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <full-calendar 
              ref="calendar" 
              :config="config" 
              :events="events" 
              :editable="false"
              @event-selected="eventSelected"/>
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
                    locale: this.$i18n.locale,
                    buttonText: {
                        today: this.$t("calendar.today"),
                        month: this.$t("calendar.month"),
                        week: this.$t("calendar.week"),
                        day: this.$t("calendar.day"),
                        list: this.$t("calendar.list"),
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
        beforeMount() {
            axios.get('/api/calendar').then(response => {
                this.events = response.data
            });

            this.$bus.$on('change-language', (args) => {
                if (this.$refs.calendar !== undefined && this.$refs.calendar !== null) {
                    this.config.buttonText = {
                        today: this.$t("calendar.today"),
                        month: this.$t("calendar.month"),
                        week: this.$t("calendar.week"),
                        day: this.$t("calendar.day"),
                        list: this.$t("calendar.list"),
                    };
                    this.locale = this.$i18n.locale;

                    this.$refs.calendar.fireMethod('option', 'buttonText', this.config.buttonText)
                    this.$refs.calendar.fireMethod('option', 'locale', this.locale)
                }
            })
        },
        methods: {
            eventSelected(event, jsEvent, view) {
                this.$bus.$emit('open-modal', event)
            }
        },
    }
</script>

<style>
@import 'fullcalendar/dist/fullcalendar.min.css';
</style>