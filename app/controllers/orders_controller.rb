class OrdersController < ApplicationController
  before_action :signed_in_user, only: [:create]

  def index
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "Order created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  private

    def order_params
      params.require(:order).permit(:lengh)
    end
end
