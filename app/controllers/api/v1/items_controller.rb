class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    require "pry"; binding.pry
      merchant = Merchant.find(params[:merchant_id])
      item = merchant.items.create(item_params)
      render json: ItemSerializer.new(item)
    end

  def update
    render json: ItemSerializer.new(Item.update(item_params))
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
