Rails.application.routes.draw do
  namespace :api do
    get 'auth/login'
  end

  namespace :api do
    get 'auth/logout'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i(create)
end
