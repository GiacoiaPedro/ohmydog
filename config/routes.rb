Rails.application.routes.draw do
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

  # Defines the root path route ("/")
   root "dashboard#index"
end
