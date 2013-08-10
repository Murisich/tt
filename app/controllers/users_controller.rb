# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Профиль успешно обновлен"
      sign_in @user
      redirect_to @user
    else 
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:success] = "Регистрация прошла успешно. Добро пожаловать на Helloworld!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
