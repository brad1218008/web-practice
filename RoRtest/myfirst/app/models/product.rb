class Product < ApplicationRecord
  has_many :product_categories
  has_many :order_items
  
end
