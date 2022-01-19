class TasksController < ApplicationController
  before_action :selected_task, only: %i[show edit update destroy]

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
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_url
  end

  private

  def task_params
    params.require(:task).permit(:content, :priority, :deadline, :status)
  end

  def selected_task
    @task = Task.find(params[:id])
  end
end
