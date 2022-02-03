class TasksController < ApplicationController
  helper_method :sort_direction, :sort_column
  
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    return if !logged_in?

    if params[:task_search]
      keyword = params[:task_search][:keyword]
      status = params[:task_search][:status_num]
      return @tasks = current_user.tasks.includes(:labels).where(labels: { id: params[:label_id] } ).show_search_result(keyword, status).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10) if params[:label_id].present?
      @tasks = current_user.tasks.includes(:labels).show_search_result(keyword, status).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    else
      return @tasks = current_user.tasks.includes(:labels).where(labels: { id: params[:label_id] } ).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10) if params[:label_id].present?
      @tasks = current_user.tasks.includes(:labels).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    end
  end

  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])

    return if current_user.admin?

    redirect_to root_url unless current_user.tasks.include?(@task)
  end

  def task_params
    params.require(:task).permit(:title, :content, :priority, :deadline, :task_status, label_ids: [])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'tasks.created_at'
  end
end
