class Api::V1::Merchants::SearchController < ApplicationController
  def index
    search_params.each do |key, value|
      merchants = []
      merchants << Merchant.where("#{key} ilike ?", "%#{value}%")
      render json: merchants.flatten
    end
  end

  def show
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
