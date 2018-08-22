<template>
  <footer class="main-footer">
    <div class="pull-right">
      <select v-model="selectedLanguage">
        <option v-for="lang in langs" :value="lang.id">
          {{ lang.name }}
        </option>
      </select>
    </div>
    <strong>Copyright &copy; 2017-2018.</strong> All rights reserved.
  </footer>
</template>

<script>
    export default {
        mounted() {
            console.log('Footer mounted');
        },
        data() {
            return {
                selectedLanguage: this.$i18n.locale,
                langs: [
                    {
                        id: 'en',
                        name: 'English',
                    },
                    {
                        id: 'pt',
                        name: 'Português'
                    }
                ]
            }
        },
        watch: {
            'selectedLanguage': function (val, oldVal) {
                this.$i18n.locale = val
                this.$ls.set('locale', val)
                this.$bus.$emit('change-language', null)
            },
        },
    }
</script>

<style scoped>

</style>