class TasksController < ApplicationController
  def index
    @tasks = Task.all
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
    params.require(:task).permit(:title, :content, :priority, :deadline, :status)
  end
end
