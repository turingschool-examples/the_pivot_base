class Admin::Stores::ItemsController < ApplicationController
  # before_action :require_admin
  def index
    store = Store.find_by(slug: params[:store])
    @items = store.items
  end

  def new
    store = Store.find_by(slug: params[:store])
    @item = store.items.build
  end

  def create
    @categories = Category.all
    store = Store.find_by(params[:name])
    @item = store.items.build(item_params)
    if @item.save
      redirect_to admin_store_items_path()
    else
      render :new
    end
  end

  def update
    @categories = Category.all
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to admin_store_items_path
    else
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params

   authorization = {
    cloud_name: ENV['cloud_name'],
    api_key:    ENV['cloudinary_api_key'],
    api_secret: ENV['cloudinary_secret']
   }

   if params[:item][:image].nil?
     params[:item][:image] = "http://res.cloudinary.com/le-pivot/image/upload/v1518274406/book_cover.png"
   else
     response = Cloudinary::Uploader.upload(params[:item][:image].tempfile.path, authorization)
     params[:item][:image] = response['url']
   end

   params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end

  def require_admin
    render file: "/public/404" unless current_store_admin?
  end
end
