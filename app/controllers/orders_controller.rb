# -*- coding: utf-8 -*-
class OrdersController < ApplicationController
  include AlipayGeneratable

  before_action :signed_in_user, only: [:create]

  def pay
    order = current_user.orders.find params[:id]
    if order.status <=1
      redirect_to generate_pay_link_by_order(order)
    else
      redirect_back_or user_orders_path
    end
  end

  def alipay_done
    callback_params = params.except(*request.path_parameters.keys)
    if callback_params.any? && Alipay::Sign.verify?(callback_params) && params[:trade_status] == 'TRADE_SUCCESS'
      @order = current_user.orders.find params[:id]
      @order.pay!(params[:trade_no]) if @order.pending?
    end
  end

  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)
    if Alipay::Sign.verify?(notify_params) && Alipay::Notify.verify?(notify_params)
      @order = EventOrder.find params[:id]
      if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(params[:trade_status])
        @order.pay!(params[:trade_no]) if @order.pending?
      elsif params[:trade_status] == 'TRADE_CLOSED'
        @order.cancel!
      end
      render text: 'success'
    else
      render text: 'fail'
    end
  end

  def index
  end

  def upload
  end

  def show
    @order = current_user.orders.find params[:id]
    respond_to do |format|
      if @order
        format.js
      else
      end
    end
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
        format.html { render'new' }
        format.js { render 'fail' }
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
