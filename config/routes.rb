Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy', as: 'signout'

  get '/login',     :to => 'sessions#new', :as => 'login'
  post '/login',    :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'


  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items,     only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
  end

  resources :users ,    only: [:new, :create, :edit, :update]
  resources :orders,    only: [:index, :new, :show, :update]
  resources :dashboard, only: [:index]
  resources :items,     only: [:index, :show]
  resource  :cart,      only: [:show, :create, :destroy, :update]

  get '/:category', to: 'categories#show', param: :slug, as: "category"
end
