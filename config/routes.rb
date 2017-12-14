Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy', as: 'signout'

  get    '/login',  to: 'sessions#new', as: 'login'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items,     only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]

    get '/stores/pending',   to: 'stores#index'
    get '/stores/suspended', to: 'stores#index'
    get '/stores/active',    to: 'stores#index'

    resources :stores, only: [:index, :show, :update]
  end

  namespace :users do
    resources :stores, only: [:index]
  end

  namespace :settings do
    get '/developer/', to: 'developer#show'
    get '/developer/new', to: 'developer#new'
    get '/developer/create', to: 'developer#create'
  end

  resources :users, only: [:new, :create, :edit, :update]
  get "/account/edit", to: "users#edit"

  resources :orders,    only: [:index, :new, :show, :update]
  resources :dashboard, only: [:index]
  resources :items,     only: [:index, :show]
  resource  :cart,      only: [:show, :create, :destroy, :update]

  get '/categories/:category', to: 'categories#show', param: :slug, as: "category"

  resources :stores, only: [:new, :create]
end
