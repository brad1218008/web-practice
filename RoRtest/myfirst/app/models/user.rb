class User < ApplicationRecord
  has_many :order_items
  has_many :orders
  before_save :set_subtotal
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def subtotal
    order_items.collect{|order_item| order_item.valid? ? (order_item.unit_price*order_item.quantity) : 0}.sum
  end
  
  private
    def set_subtotal
      self[:subtotal] = subtotal
    end
end
