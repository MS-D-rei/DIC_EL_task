class UsersController < ApplicationController
  helper_method :sort_direction, :sort_column
  
  before_action :logged_in_user, only: %i[show edit update]
  before_action :correct_user, only: %i[edit update]

  def index
  end

  def show
    @user = User.find(params[:id])
    if params[:task_search]
      keyword = params[:task_search][:keyword]
      status = params[:task_search][:status_num]
      @tasks = @user.tasks.show_search_result(keyword, status).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    else
      @tasks = @user.tasks.all.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    end

    return if current_user.admin?

    render 'tasks/index' unless current_user?(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Your account has been created.'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile has been updated.'
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])

    return if current_user.admin?

    redirect_to root_url unless current_user?(@user)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
