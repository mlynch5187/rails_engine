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
    # Since we are actually destroying this resource the conventional response is to return a 204 status with no content rather than returning the deleted resource
    json_response(serializer(Merchant.destroy(params[:id])))
  end

  private

  def serializer(object)
    MerchantSerializer.new(object)
  end

  def merchant_params
    # The create functionality was likely failing the spec harness because it is expecting to be able to pass a body that looks like {name: 'Awesome Name'} without having a key of merchant. You just need to remove the `require(:merchant)` from the strong params here
    params.require(:merchant).permit(:name)
  end
end
