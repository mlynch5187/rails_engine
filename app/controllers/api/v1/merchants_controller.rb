class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(params))
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  def destroy
    Merchant.find(params[:id]).items.destroy_all
    render json: MerchantSerializer.new(Merchant.destroy(params[:id]))
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
