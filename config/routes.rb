Rails.application.routes.draw do
  # resources :users do
    resources :projects do
      resources :tasks do
        resources :comments
        member do
          patch :complete
        end
      end
    end
  # end
  devise_for :users
  get 'home/index'
  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
