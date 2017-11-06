Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :users do
        collection do
          post 'search'
        end
      end
    end
  end
end
