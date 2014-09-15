Rails.application.routes.draw do
  
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :messages, except: [:new, :edit]
    end
  end

  get 'public/index'

  root to: 'public#index'
end
