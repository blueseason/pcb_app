# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = t('user.update_profile_succ')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.login_count = 0
      @user.last_login_time= @user.created_at
      sign_in @user
      flash[:success] = t('signup_welcome')
      redirect_to @user
    else
      render 'new'
    end
  end

   private

    def user_params
      params.require(:user).permit(:name, :real_name, :email, :password,
                                   :password_confirmation, :mobile,
                                   :qq, :company_name, :phone,
                                   :fax, :address)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
