class TasksController < ApplicationController
  before_action :selected_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show
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

  def task_params
    params.require(:task).permit(:title, :content, :priority, :deadline, :status)
  end

  def selected_task
    @task = Task.find(params[:id])
  end
end
