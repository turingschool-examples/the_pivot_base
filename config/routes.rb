Rails.application.routes.draw do

  root :to => 'main#index'

  get '/auth/twitter',           as: :twitter_login
  get '/twitter_logout',         to: 'sessions#destroy_twitter', as: :twitter_logout
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to:  redirect('/')
  get 'signout',                 to: 'sessions#destroy', as: 'signout'

  get    '/login',  to: 'sessions#new', as: 'login'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get    '/search', to: 'search#index'

  resources :tweet, only: [:new, :create]

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :analytics, only: [:index]

    get '/stores/pending',   to: 'stores#index'
    get '/stores/suspended', to: 'stores#index'
    get '/stores/active',    to: 'stores#index'

    resources :stores, only: [:index, :show, :update]

    resources :store, param: :slug, as: 'store' do
      resources :items, only: [:index, :edit, :new, :create, :update]
    end
  end

  namespace :users do
    resources :stores, only: [:index]
  end

  namespace :settings do
    get '/developer/',       to: 'developer#show'
    get '/developer/new',    to: 'developer#new'
    get '/developer/create', to: 'developer#create'
  end

  resources :users, only: [:new, :create, :edit, :update]

  get "/account/edit", to: "users#edit"

  resources :orders,    only: [:index, :new, :show, :update, :create]
  resources :dashboard, only: [:index]
  resources :items,     only: [:show]
  resource  :cart,      only: [:show, :create, :destroy, :update]
  resources :stores, only: [:index, :new, :create]
  resources :messages

  get '/chatrooms/:chatroom',  to: 'chatrooms#show',  param: :slug, as: 'chatroom'
  get '/categories/:category', to: 'categories#show', param: :slug, as: "category"

  get '/:store', to: 'items#index', param: :slug, as: 'store'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/search' , to: 'search#index'
      match '*a',     to: 'base#route_not_found', via: :get
    end
  end

  mount ActionCable.server => '/cable'
end
