Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    post 'auth/login'
    delete 'auth/logout'

    resources :users, only: %i(create)

    resources :bills, except: %i(new edit)
  end

  match '*path', to: 'api/base#no_route', via: :all
end
