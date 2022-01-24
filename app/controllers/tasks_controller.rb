class TasksController < ApplicationController
  helper_method :sort_direction, :sort_column

  def index
    if params[:task_search]
      keyword = params[:task_search][:keyword]
      status = params[:task_search][:status_num]
      @tasks = Task.show_search_result(keyword, status).order("#{sort_column} #{sort_direction}")
    else
      @tasks = Task.all.order("#{sort_column} #{sort_direction}")
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'New task created'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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

  def task_params
    params.require(:task).permit(:title, :content, :priority, :deadline, :task_status)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'deadline'
  end
end
