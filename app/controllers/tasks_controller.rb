class TasksController < ApplicationController
  helper_method :sort_direction, :sort_column

  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    return if !logged_in?

    if params[:task_search]
      keyword = params[:task_search][:keyword]
      status = params[:task_search][:status_num]
      @tasks = current_user.tasks.show_search_result(keyword, status).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    else
      @tasks = current_user.tasks.all.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    end
  end

  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'New task created'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task updated'
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'Task deleted'
    redirect_to root_url
  end

  private

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :deadline, :task_status)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
