class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @order_items = current_user.order_items
    @order = current_user.orders.new(order_params)
  end
  def create
    @user = current_user
    @order = @user.orders.new(order_params)
    @user.save
    session[:user_id] = current_user.id 
  end
  
  private
    def order_params
      params.permit(:first_name, :last_name, :address, :phone_number, :order_price)
    end
end
