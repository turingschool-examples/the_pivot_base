Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get '/login', :to => 'sessions#new', as: 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  namespace :admin do
    controller :stores do
      get '/:store_name' => :show, as: 'store'
      get '/:store_name/edit' => :edit, as: 'edit_store'
      put '/:store_name' => :update
      delete '/:store_name' => :destroy


      controller :items do
        post '/:store_name/items' => :create
        get '/:store_name/items' => :index, as: 'store_items'
        get '/:store_name/items/new' => :new, as: 'new_store_item'
        get '/:store_name/:item_name/edit' => :edit, as: 'edit_store_item'
        get '/:store_name/:item_name' => :show, as: 'store_item'
        put '/:store_name/:item_name' => :update
        patch '/:store_name/:item_name' => :update
        delete '/:store_name/:item_name' => :destroy
      end

      controller :orders do
        get '/:store_name/orders' => :index, as: 'store_orders'
        get '/:store_name/orders/:id' => :show, as: 'store_order'
        put '/:store_name/orders/:id' => :update
      end

      controller :store_users do
        get '/:store_name/admins/new' => :new, as: 'new_store_user'
        post '/:store_name/admins' => :create
        get '/:store_name/admins/:id' => :edit, as: 'edit_store_user'
        put '/:store_name/admins/:id' => :update
        get '/:store_name/admins/:id' => :show, as: 'store_admin'
        delete '/:store_name/admins/:id' => :destroy
        get '/:store_name/admins' => :index, as: 'store_admins'
      end
    end
  end

  namespace :platform_admin do
    get '/dashboard' => :index
    resources :users
    resources :categories
  end

  namespace :store_admin do
    get '/dashboard' => :index
  end

  namespace :store_manager do
      get '/dashboard' => :index
  end

  resources :users , only: [:new, :create ] do
    resources :orders, only: [:create, :index, :show]
  end

  get '/account/edit', to: 'user#edit'
  put '/account', to: 'user#update'

  resources :dashboard, only: [:index]

  resource :cart, only: [:create, :destroy, :update, :show]



  get '/stores/new', to: 'stores#new', as: 'new_store'

  post '/stores', to: 'stores#create'

  get '/:store_name', to: 'stores#show', as: 'store'

  get '/:store_name/:item_name', to: 'items#show', as: 'store_item'

  get '/categories/:category_name', to: 'categories#show', as: 'category'

end
