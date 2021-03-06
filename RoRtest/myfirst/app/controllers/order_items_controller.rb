class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @order = current_user
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = current_user.id
  end
  
  def update
    @order = current_user
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end
  
  def destroy
    @order = current_user
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end
    
  
  private
    def order_item_params
      params.require(:order_item).permit(:product_id, :quantity)
    end
end
