class Admin::UsersController < ApplicationController
  helper_method :sort_direction, :sort_column

  before_action :check_admin

  def index
    @users = User.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def check_admin
    redirect_to root_url unless current_user.admin?
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
