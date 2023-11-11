Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'dashboard/perros_perdidos'
  get 'dashboard/solicitar_turno'
  get 'dashboard/cuidadores'
  get 'dashboard/perros_encontrados'
  get 'dashboard/adopciones'
  get 'dashboard/cruza_de_perros'
  get 'dashboard/paseadores'  
  get 'dashboard/iniciar_sesion'
  get 'dashboard/mi_usuario'
  get 'dashboard/registrar_perro'
  get 'dashboard/registrar_usuario'
  get 'dashboard/modificar_usuario'
  get 'dashboard/eliminar_usuario'
  get 'dashboard/turnos_confirmados'
  get 'dashboard/turnos_pendientes'

  # Defines the root path route ("/")
   root "dashboard#index"
end
