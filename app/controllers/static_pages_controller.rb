class StaticPagesController < ApplicationController
  def home
    @order = current_user.orders.build if signed_in?
  end

  def help
  end
end
