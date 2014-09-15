Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :messages, except: [:new, :edit]
    end
  end

  get 'public/index'

  root to: 'public#index'
end
