require 'pry'
class Cart < ActiveRecord::Base
  belongs_to :user 
  has_many :line_items
  has_many :items, through: :line_items

  def total
    total = 0 
    self.line_items.each do |line_item| 
      item = Item.find_by(id: line_item.item_id)
      amount = item.price * line_item.quantity
      total = total + amount 
    end 
    total 
  end

    def checkout
      self.line_items.each do |line_item|
        line_item.item.update_inventory(line_item) 
      end 
    end 

    def add_item(item_id)
      if items.find_by(id: item_id)
        @line_item = self.line_items.find_by(item_id: item_id)
        @line_item.quantity += 1
        @line_item
      else 
        @line_item = LineItem.new(cart_id: self.id, item_id: item_id)
      end 
    end

  def create_cart(the_item) 
    i = self.line_items.find {|item| item.item_id == the_item.id}
    if i == nil 
      self.items << the_item 
    else 
      i.quantity += 1
      i.save 
    end 
  end 

end
