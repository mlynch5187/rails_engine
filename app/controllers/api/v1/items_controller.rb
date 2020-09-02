class Api::V1::ItemsController < ApplicationController

  def index
    json_response(serializer(Item.all))
  end

  def show
    json_response(serializer(Item.find(params[:id])))
  end

  def create
    merchant = Merchant.find(item_params[:merchant_id])
    item = merchant.items.create(item_params)
    json_response(serializer(item))
  end

  def update
    json_response(serializer(Item.update(item_params)))
  end

  def destroy
    json_response(serializer(Item.destroy(params[:id])))
  end

  private

  def serializer(object)
    ItemSerializer.new(object)
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
