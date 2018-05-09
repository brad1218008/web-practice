class HomeController < ApplicationController
    before_action :authenticate_user!, except: [:index,:goods]
    MAX_PRODUCT_NUMBER = 9
    
    def index 
        @ad = {
            title: "大型廣告1",
            des: "這是廣告",
            action: "Learn more"
            }
        
        if params[:page]
            @pages = params[:page].to_i
        else
            @pages = 1
        end
        
        if params[:category]
#          @product_category = ProductCategory.where(category_id: 7)
#          @product = Product
#          p = Product.new
#          @product_category.each do |o|
#            p = Product.where(id: o.product_id)
#            @product.new(p)
#          end
          @product = Product.joins(:product_categories).where('product_categories.category_id': params[:category].to_i)

          @fist_page = 1
          @last_page = (@product.count.to_f / MAX_PRODUCT_NUMBER.to_f).ceil
#          @product = @product[((@pages-1)*MAX_PRODUCT_NUMBER),(MAX_PRODUCT_NUMBER)]
          @product = @product.offset((@pages-1)*MAX_PRODUCT_NUMBER).limit(MAX_PRODUCT_NUMBER)
          @current_category = :category
        else
          @product = Product.all
          @fist_page = 1
          @last_page = (@product.count.to_f / MAX_PRODUCT_NUMBER.to_f).ceil
          @product = @product.offset((@pages-1)*MAX_PRODUCT_NUMBER).limit(MAX_PRODUCT_NUMBER)
        end
      
        
#        (1..TOTAL_PRODUCT_NUMBER).each do |index|
#            pro = {
#                id: index,
#                name: "捲餅#{index}",
#                des: "內餡飽滿，料豐味美",
#                foot: "Last updated 3 mins ago",
#                image_url: "https://static.pexels.com/photos/461198/pexels-photo-461198.jpeg"
#                }
#            @product << pro
#        end
        
      if user_signed_in?
        @order_item = current_user.order_items.new
      end
    end
    
    def goods
      @goodName = params[:name]
      @thisGood = Product.find_by name: @goodName
      if user_signed_in?
        @order_item = current_user.order_items.new
      end
    end
  
end
