class Api::V1::ItemsController < ApplicationController

  def index
    json_response(serializer(Item.all))
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    merchant = Merchant.find(item_params[:merchant_id])
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

  def serializer(object)
    ItemSerializer.new(object)
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
