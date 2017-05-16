require 'pry'
class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def create 
    if current_user.current_cart == nil 
      current_user.current_cart = Cart.create(user_id: current_user.id)
    end 

    @item = Item.find_by(id: params[:item_id])
    @cart = current_user.current_cart
    @cart.create_cart(@item)
    current_user.save 
    redirect_to cart_path(@cart)
  end 
end
