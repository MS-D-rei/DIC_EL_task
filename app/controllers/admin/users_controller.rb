class Admin::UsersController < ApplicationController
  helper_method :sort_direction, :sort_column

  before_action :check_admin

  def index
    @users = User.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Created new account'
      redirect_to admin_users_path
    else
      render 'users/new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    admin = @user.admin ? false : true

    if admin == false && User.where(admin: true).count == 1
      flash[:danger] = "Cant't change admin status because current number of admin is 1"
    else
      @user.update_attribute(:admin, admin)
    end

    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def check_admin
    return if current_user.admin?

    flash[:info] = "Not admin user can't access admin page"
    redirect_to root_url
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'tasks_count'
  end
end
