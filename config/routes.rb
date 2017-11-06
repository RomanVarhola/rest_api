Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      devise_for :users
      #resources :registration, only: %i[create]
      #resources :sessions, only: %i[create destroy]
      resources :users
    end
  end

end
