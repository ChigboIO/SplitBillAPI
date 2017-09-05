Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    post 'auth/login'
    delete 'auth/logout'

    resources :users, only: %i(create)
  end

  match '*path', to: 'api/base#no_route', via: :all
end
