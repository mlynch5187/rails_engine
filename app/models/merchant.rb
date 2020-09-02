class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.revenue_total; end
end
