Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'


  namespace :admin do
    resources :platform_admin_dashboard, only: [:index]
    resources :store_admin_dashboard, only: [:index]
    resources :store_manager_dashboard, only: [:index]
    resources :stores do
      resources :users, only: [:update]
    end


  end

  resources :users , only: [:new, :create, :edit, :update] do
    resources :orders, only: [:create, :index, :show, :update]
  end

  resources :dashboard, only: [:index]

  resources :cart, only: [:create, :destroy, :update, :show]

  get '/:store_name', to: 'stores#show', as: 'store'

  get '/:store_name/:item_name', to: 'items#show', as: 'store_item'

  get '/categories/:category_name', to: 'categories#show', as: 'category'

  get '/:item_name', to: 'items#show', as: 'item'

end
