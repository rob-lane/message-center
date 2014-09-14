Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, only: [:index, :show, :create]
    end
  end

  get 'public/index'

  root to: 'public#index'
end
