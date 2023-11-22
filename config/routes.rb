Rails.application.routes.draw do
  get 'perros/new'
  get 'perros/create'
  get 'user_search/search'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }


    resources :historial_turnos

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'dashboard/perros_perdidos'
  get 'dashboard/solicitar_turno'
  get 'servicios/cuidadores'
  get 'dashboard/perros_encontrados'
  get 'dashboard/adopciones'
  get 'dashboard/cruza_de_perros'
  get 'servicios/paseadores'  
  get 'dashboard/iniciar_sesion'
  get 'dashboard/mi_usuario'
  get 'dashboard/registrar_perro'
  get 'dashboard/registrar_usuario'
  get 'dashboard/modificar_usuario'
  get 'dashboard/eliminar_usuario'
  get 'dashboard/turnos_confirmados'
  get 'dashboard/turnos_pendientes'
  get 'dashboard/index'
  get '/perros/mis_perros'
  get '/users/search', to: 'user_search#search'
  get '/perros/registrar_perro', to: 'perros#new', as: 'registrar_perro'
  get 'perros/editar_perro'
  get 'cargar_cuidador', to: 'servicios#cargar_cuidador', as: :cargar_cuidador
  get 'cargar_paseador', to: 'servicios#cargar_paseador', as: :cargar_paseador
  post '/guardar_cuidador', to: 'servicios#guardar_cuidador'
  post '/guardar_paseador', to: 'servicios#guardar_paseador'

# En config/routes.rb
resources :perros



  get 'mis_perros', to: 'perros#mis_perros', as: 'mis_perros'

  # config/routes.rb

  # config/routes.rb

  resources :usuarios, controller: 'dashboard', only: [] do
    member do
      patch :eliminar
    end
  end

  devise_scope :user do
    get 'users/edit_password', to: 'users/registrations#edit_password', as: 'edit_password_user'
    put 'users/update_password', to: 'users/registrations#update_password', as: 'update_password_user'
  end

  resources :user_search, only: [] do
    collection do
      get 'search'
    end
  end

  root "dashboard#index"
end
