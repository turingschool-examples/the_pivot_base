Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  namespace :admin do
    controller :stores do
      get '/:store_name/new' => :new, as: 'new_store'
      post '/:store_name' => :create
      get '/:store_name' => :show, as: 'store'
      get '/:store_name/edit' => :edit, as: 'edit_store'
      put '/:store_name' => :update
      delete '/:store_name' => :destroy


      controller :items do
        get '/items' => 'index', as: 'store_items'
        get '/:store_name/items/new', to: 'stores/items#new', as: 'store_items'
        get '/:store_name/:item_name/edit', to: 'stores/items#edit', as: 'edit_store_item'
        get '/:store_name/:item_name', to: 'stores/items#show', as: 'store_item'
        put '/:store_name/:item_name', to: 'stores/items#update'
      end

      controller :orders do
        get '/:store_name/orders', to: 'stores/orders#index'
        get '/:store_name/orders/:id', to: 'stores/orders#show'
        put '/:store_name/orders/:id'
      end

      controller :store_users do
        get '/:store_name/admins/:id', to: 'stores/admin#show'
        put '/:store_name/admins/:id'
      end

    end


  end

  namespace :platform_admin do
    get '/dashboard' => :index
    resources :users
    resources :categories
    resources :stores do
      resources :store_users
      resources :items
    end
    resources :orders, except: [:destroy]
  end

  namespace :store_admin do
    get '/dashboard' => :index
    get '/:store_name', to: 'stores#show', as: 'store'
    get '/:store_name/edit', to: 'stores#edit', as: 'edit_store'
    put '/:store_name', to: 'stores#update'
    get '/:store_name/items', to: 'stores/items#index', as: 'store_items'
    get '/:store_name/:item_name', to: 'stores/items#show', as: 'store_item'
      resources :items
      resources :store_users
      resources :orders, only: [:index, :show, :update]
  end

  namespace :store_manager do
      get '/dashboard' => :index
      get '/:store_name', to: 'stores#show', as: 'store'
      get '/:store_name/:item_name', to: 'stores/items#show', as: 'store_item'
      get '/:store_name/:item_name/edit', to: 'stores/items#edit', as: 'edit_store_item'
      put '/:store_name/:item_name', to: 'stores/items#update'
      resources :orders, only: [:index, :show, :update]
  end


  resources :users , only: [:new, :create, :edit, :update] do
    resources :orders, only: [:create, :index, :show]
  end

  resources :dashboard, only: [:index]

  resources :cart, only: [:create, :destroy, :update, :show]

  get '/:store_name', to: 'stores#show', as: 'store'

  get '/:store_name/new', to: 'stores#new', as: 'new_store'

  get '/:store_name/:item_name', to: 'items#show', as: 'store_item'

  get '/categories/:category_name', to: 'categories#show', as: 'category'

  get '/:item_name', to: 'items#show', as: 'item'

end
