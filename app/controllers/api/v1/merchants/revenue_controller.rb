class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.revenue_total(params[:merchant_id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
