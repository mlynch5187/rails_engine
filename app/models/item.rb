class Item < ApplicationRecord
  def price_to_dollars
    require "pry"; binding.pry
  end
end
