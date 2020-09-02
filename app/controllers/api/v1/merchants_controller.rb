class Api::V1::MerchantsController < ApplicationController

  def index
    json_response(serializer(Merchant.all))
  end

  def show
    json_response(serializer(Merchant.find(params[:id])))
  end

  def create
    json_response(serializer(merchant_params))
  end

  def update
    json_response(serializer(Merchant.update(params[:id], merchant_params)))
  end

  def destroy
    json_response(serializer(Merchant.destroy(params[:id])))
  end

  private

  def serializer(object)
    MerchantSerializer.new(object)
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
