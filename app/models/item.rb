require 'pry'
class Item < ActiveRecord::Base
  has_many :line_items 
  belongs_to :category 

 def update_inventory(li)
    self.inventory = self.inventory - li.quantity
    self.save
  end

  def self.available_items
    all.select {|item| item.inventory > 0}
  end
  
end
