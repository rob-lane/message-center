Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      #This will be a full resource eventually
      get 'messages/index'
      get 'messages/show'
  end

  get 'public/index'

  root to: 'public#index'
end
