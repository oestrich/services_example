class OrdersController < ApplicationController
  def create
    service = OrderCreationService.new(current_user, params[:order])
    service.perform

    if service.successful?
      render :json => service.order, :status => 201
    else
      render :json => service.errors, :status => 422
    end
  end

  def current_user
    User.first
  end
end
