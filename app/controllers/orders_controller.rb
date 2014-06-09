# -*- coding: utf-8 -*-
class OrdersController < ApplicationController
  before_action :signed_in_user, only: [:create]

  def index
  end

  def calc
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    #@order.type = 0
    respond_to do |format|
      if @order.save
        format.html { flash[:success] = "Order created!" }
        format.js
      else
        format.js { render 'new' }
      end

    end

  end

  private

    def order_params
      params.require(:order).permit(:length,:type, :width, :layer, :amount,
                                    :pinban_style_num, :thickness,
                                    :zuhan_color, :zifu_color,
                                    :hanpan_pengdu, :zuhan_cover,
                                    :test, :tongbo_thickness,
                                    :produce_time, :need_receipt,
                                    :express, :comment)
    end
end
