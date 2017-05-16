require 'pry'
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show 
    @current_cart = current_user.current_cart || Cart.new 
    @items = @current_cart.items 
  end

  def checkout
    flash[:message] = "submitted"
    @cart = Cart.find(params[:id])
    @cart.checkout 
    current_user.current_cart = nil 
    current_user.save
    redirect_to cart_path(@cart)
   end

  private

  def cart_params
    params.require(:cart).permit(:user_id)
  end 
end
