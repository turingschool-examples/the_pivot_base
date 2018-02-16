
Rails.application.routes.draw do

  root :to => 'stores#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  resources :charges, only: [:create]

  get '/account/edit', to: 'users#edit'

  namespace :stores, as: :store, path: ':store' do
    resources :items, only: [:index, :show]
    resources :categories, only: [:index]
  end


  namespace :admin do
    namespace :stores, as: :store, path: ':store' do
      resources :items, only: [:index, :show, :edit, :create, :new, :update]
      resources :users, only: [:index, :show, :edit, :create, :new, :update]
      resources :dashboard, only: [:index]
      resources :analytics, only: [:index]
    end

    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
  end

  resources :stores, param: :slug, only: [:edit, :update, :new, :create]
  resources :users , only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :new, :show, :update]
  resources :dashboard, only: [:index]

  get '/shipping', :to => 'shipping#show', :as => 'shipping'
  get '/cart', :to => 'carts#index', :as => 'cart'
  resources :carts, only: [:index, :create, :destroy]
  patch '/cart', :to => 'carts#update'
  delete '/cart', :to => 'carts#destroy'

  get '/:category', to: 'categories#show', param: :slug, as: "category"

end
