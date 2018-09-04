<template>
  <footer 
    v-if="['Login'].indexOf($route.name) !== 0" 
    class="main-footer">
    <div class="pull-right">
      <select v-model="selectedLanguage">
        <option 
          v-for="lang in langs"
          :key="lang.id">
          {{ lang.name }}
        </option>
      </select>
    </div>
    <strong>Copyright &copy; 2017-2018.</strong> All rights reserved.
  </footer>
</template>

<script>
    export default {
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
                const lang = (val === 'English' ? 'en' : 'pt');
                this.$i18n.locale = lang;
                this.$ls.set('locale', lang)
                this.$bus.$emit('change-language', null)
            },
        },
        mounted() {
            console.log('Footer mounted');
        },
    }
</script>

<style scoped>

</style>