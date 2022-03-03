class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user , only: [:show,:edit,:update,:destroy]

  def index
    @users = User.select(:id, :name, :email, :created_at,:admin).includes(:tasks).order(id:"ASC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "新規ユーザー作成"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "編集しました"
      redirect_to admin_users_path
    else
      flash[:notice] = "編集できません"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_users_path
  end

  private

  def admin_user
    unless current_user.admin?
      flash[:notice] = "管理者以外はアクセスできません"
      redirect_to tasks_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:admin,:password_confirmation)
  end

end
