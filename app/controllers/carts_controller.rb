class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index 
    @cart_decorator = CartDecorator.new(@cart)
  end

  def create
    # <%= link_to "Checkout", new_order_path%>
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.title)}."
    redirect_back(fallback_location: root_path)
  end

  def update
    item_id = params[:id]
    @cart_item = CartItem.new(item_id, 1)
    if params[:condition] == "decrease"
      @cart.decrease_quantity(item_id)
      if @cart.contents[item_id].nil?
        flash[:successfully_removed] = "Successfully removed <a href=#{store_item_path(@cart_item.store, @cart_item.item)}>#{@cart_item.item.title}</a> from your cart."
      end
    elsif params[:condition] == "increase"
      @cart.increase_quantity(item_id)
    end
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart_item = CartItem.new(params[:id], 1)
    @cart.delete_item(item.id)
    flash[:successfully_removed] = "Successfully removed <a href=#{store_item_path(@cart_item.store, @cart_item.item)}>#{@cart_item.item.title}</a> from your cart."
    redirect_back(fallback_location: root_path)
  end

  def post
  end

  private
    def params_id
      params.permit(:id)
    end


end
