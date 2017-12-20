Rails.application.routes.draw do
  resources :charges, only: [:new, :create]

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
    resources :stores, only: [:index]
  end

  namespace :owner do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :stores, only: [:index]
  end
   
  get "api/v1/search", to: "api/v1/search#index"

  namespace :users do
    resources :credit_cards, only: [:new, :create, :update, :show]
  end
  post 'users/credit_cards/create'

  get 'tweets/new'

  get 'tweets/create'

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  resources :tweets, only: [:new, :create]

  namespace :stores, as: :store, path: ":store" do
    resources :items, only: [:index, :show, :new, :create, :update, :edit]
  end

  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  resources :users , only: [:new, :create, :edit, :update]

  resources :stores, only: [:new, :create, :index, :show]

  get '/account/edit', to: 'users#edit', as: 'account_edit'

  resources :orders, only: [:index, :create, :show, :update]

  resources :dashboard, only: [:index]

  get '/cart', :to => 'carts#index', :as => 'cart'

  resources :carts, only: [:index, :create, :destroy]

  patch '/cart', :to => 'carts#update'

  delete '/cart', :to => 'carts#destroy'
  resources :carts, only: [:index, :create, :destroy]
  
  resources :categories, param: :slug, only: [:show]

  get  "/settings",           to: 'developer#new'
  get  "/settings/developer", to: 'developer#show'
  post "/settings/developer", to: 'developer#create'

  patch '/stores', to: 'stores#update'

  get '/search',  to: 'search#index'
  get '/:store', to: 'stores#show'

end
