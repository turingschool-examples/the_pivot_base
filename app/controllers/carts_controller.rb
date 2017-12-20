class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @items = @cart.cart_items
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.title)}."
    redirect_back(fallback_location: root_path)
  end

  def update
    item = Item.find(params[:id])
    if params[:condition] == "decrease"
      @cart.decrease_quantity(item.id)
      if @cart.contents[item.id].nil?
        flash[:successfully_removed] = "Successfully removed <a href=#{store_item_path(item.store, item)}>#{Item.find(item.id).title}</a> from your cart."
      end
    elsif params[:condition] == "increase"
      @cart.increase_quantity(item.id)
    end
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart.delete_item(item.id)
    flash[:successfully_removed] = "Successfully removed <a href=#{store_item_path(item.store, item)}>#{item.title}</a> from your cart."
    redirect_back(fallback_location: root_path)
  end

  def post
  end

end
