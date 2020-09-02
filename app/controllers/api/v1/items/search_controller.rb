class Api::V1::Items::SearchController < ApplicationController
  def index
    items = []
    search_params.each do |key, value|
      if key == "unit_price"
        items << Item.where("unit_price = ?", value.to_f)
      else
        items << Item.where("#{key} ilike ?", "%#{value}%")
      end
    end
    render json: items.flatten
  end

  def show
    item = []
    search_params.each do |key, value|
      if key == "unit_price"
        item << Item.where("unit_price = ?", value.to_f).limit(1)
      else
        item << Item.where("#{key} ilike ?", "%#{value}%").limit(1)
      end
    end
    render json: item.flatten
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :updated_at, :created_at)
  end
end
