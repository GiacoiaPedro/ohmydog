Rails.application.routes.draw do
  get 'mis_turnos/index'
  get 'perros/new'
  get 'perros/create'
  get 'user_search/search'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :campaigns, except: [:show] do
    member do
      delete :destroy
      post :pay
      get :pay # Permite solicitudes GET para la acción pay
    end
    collection do
      get :search
    end
  end

  resources :perros_perdidos, except: [:show] do
    collection do
      get 'mis_publicaciones', to: 'perros_perdidos#mis_publicaciones'
      get 'filtrar', to: 'perros_encontrados#filtrar'  
    end
    member do
      patch 'mark_found', to: 'perros_perdidos#mark_found'
    end
  end

  get 'contactar_propietario', to: 'perros_perdidos#contactar_propietario'


  resources :perros_encontrados, except: [:show] do
    collection do
      get 'mis_publicaciones', to: 'perros_encontrados#mis_publicaciones'
      get 'filtrar', to: 'perros_encontrados#filtrar'  
    end
    member do
      patch 'mark_found', to: 'perros_encontrados#mark_found'
    end
  end

  
  

  Rails.application.routes.draw do
  get 'mis_turnos/index'
    


    resources :historial_turnos do
      collection do
        get 'confirmados', to: 'historial_turnos#confirmados', as: :turnos_confirmados
        get 'pendientes', to: 'historial_turnos#pendientes', as: :turnos_pendientes
        get 'hoy', to: 'historial_turnos#hoy', as: :turnos_hoy
        put 'cancelar_turno'
      end
      member do
        put 'cancelar_turno'
        put 'agregar_horario'
        put 'agregar_texto'
        put 'agregar_consulta'
        post 'create_vaccine'
      end
    end

    
  end



  
  get 'historial_turno/mis_turnos', to: 'mis_turnos#index', as: 'mis_turnos'

  get '/users/:id/perros', to: 'user_search#perros', as: 'user_perros'    
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
  get 'dashboard/index'
  get '/perros/mis_perros'
  get '/users/search', to: 'user_search#search'
  get '/perros/registrar_perro', to: 'perros#new', as: 'registrar_perro'
  
  
  get 'perros/editar_perro'
  get 'cargar_cuidador', to: 'servicios#cargar_cuidador', as: :cargar_cuidador
  get 'cargar_paseador', to: 'servicios#cargar_paseador', as: :cargar_paseador
  post '/guardar_cuidador', to: 'servicios#guardar_cuidador'
  post '/guardar_paseador', to: 'servicios#guardar_paseador'

  match '/enviar_correo', to: 'servicios#enviar_correo', via: [:post, :delete]


  get '/paseadores', to: 'servicios#paseadores', as: 'paseadores'
  get '/cuidadores', to: 'servicios#cuidadores', as: 'cuidadores'


  resources :servicios, except: [:show] do
    member do
      get 'edit'   # Página de edición
      patch 'actualizar_servicio'   # Acción de actualización
      delete 'destroy'  # Nueva acción para eliminar
    end
  end
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
