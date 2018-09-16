Rails.application.routes.draw do
  namespace :api do
    get '/grades/provisional/partial', to: 'grades#provisional_partial'
    get '/grades/provisional/partial/years', to: 'grades#provisional_partial_years'
    get '/grades/provisional/final', to: 'grades#provisional_final'
    get '/grades/definitive/recent', to: 'grades#definitive_recent'
    get '/grades/definitive/historic', to: 'grades#definitive_historic'
    get '/assiduity', to: 'assiduity#get_assiduity'
    get '/atm', to: 'atm#get_atm'
    get '/teacher/:initials', to: 'teachers#teacher_information'
    get '/teachers', to: 'teachers#all_teachers'
    get '/exams', to: 'exams#get_exams'
    get '/menu', to: 'menu#get_menu'
    get '/queue', to: 'queue#get_queue'
    get '/calendar', to: 'calendar#index'
    get '/schedule', to: 'schedule#get_schedule'

    get '/registered', to: 'bot#registered'

    post 'login', to: 'auth#login'
    post '/register', to: 'bot#register'
    post '/update', to: 'bot#update'
    post '/mobile/device/add', to: 'firebase#register_device_id'
    post '/mobile/device/remove', to: 'firebase#remove_device_id'

    get '/admin/users', to: 'admin#get_users'
    get '/admin/check', to: 'admin#is_admin'
    get '/admin/user/:id', to: 'admin#get_user_details'
    put '/admin/user/update', to: 'admin#update_user'
    post '/admin/user/remove', to: 'admin#remove_user'
  end

  get '/', to: 'home#index'
  get '*path', to: 'home#index'
end
