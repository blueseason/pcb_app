# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      flash[:success] = "欢迎注册广东青阳科技!"
      redirect_to @user
    else
      render 'new'
    end
  end

   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :mobile,
                                   :qq, :company_name, :phone,
                                   :fax, :address)
    end
end
