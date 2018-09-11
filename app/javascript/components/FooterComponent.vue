<template>
  <footer 
    v-if="['Login'].indexOf($route.name) !== 0" 
    class="main-footer">
    <div class="pull-right">
      <select v-model="selectedLanguage">
        <option value="pt">Português</option>
        <option value="en">English</option>
      </select>
    </div>
    <strong>Copyright &copy; 2017-2018.</strong> All rights reserved.
  </footer>
</template>

<script>
    export default {
        data() {
            return {
                selectedLanguage: this.$i18n.locale
            }
        },
        watch: {
            'selectedLanguage': function (val, oldVal) {
                this.$i18n.locale = val;
                this.$ls.set('locale', val)
                this.$bus.$emit('change-language', null)
            },
        }
    }
</script>

<style scoped>

</style>