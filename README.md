# UFP-Portal

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/2ee72ee0d3284265a330498d54106b35)](https://www.codacy.com/app/joaquimmagalhaes17/UFP-Portal?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=joaquimmagalhaes17/UFP-Portal&amp;utm_campaign=Badge_Grade)

UFP-Portal it's a website that uses the information given by the Fernando Pessoa SOAP server.
This website has been created to be used in any platform (mobile phones, laptop's, etc).

This is some of the features:
  - Rest API
  - Rake task to notify new grades (new version of the UFP-Bot)
  - Push notifications using firebase
  - Email notifications
  - SMS Notifications using bulksms
  - Sidekiq + Redis to handle notifications events
  - Admin area to enable/disable users from rake task

### Tech

* [Rails] - Backend framework
* [VueJS] - Frontend framework
* [Bootstrap] - great UI boilerplate for modern web apps
* [Redis] - Awesome message broker to handle all notifications requests
* [Sidekiq] - Simple, efficient background processing for Ruby
License
----

MIT

**Free Software, Hell Yeah!**

[Rails]: <https://github.com/rails/rails>
[VueJS]: <https://github.com/vuejs/vue>
[Bootstrap]: <https://github.com/twbs/bootstrap>
[Redis]: <https://github.com/antirez/redis>
[Sidekiq]: <https://github.com/mperham/sidekiq>