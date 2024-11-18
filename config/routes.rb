require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do  
      resources :classrooms do
        collection do
          post 'join'
        end
  
        resources :posts do
          resources :comments, only: %i[index create]
          resources :responses, only: [:create, :index] 
        end
      end
    end
  
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: false) do  
      resources :classrooms
    end
  end

  match '*path', to: 'application#handle_options_request', via: :options
end
