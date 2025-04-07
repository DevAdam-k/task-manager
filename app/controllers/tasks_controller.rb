# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy complete]

  def index
    @status = params[:status]
    @tasks =
      case @status
      when "completed"
        Task.where(completed: true)
      when "pending"
        Task.where(completed: false)
      else
        Task.all
      end

    @tasks = @tasks.order(created_at: :desc)
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @task, notice: "Task was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end



  def update
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Task was successfully destroyed." }
      format.turbo_stream
    end
  end

  def complete
    @task.update(completed: true)
    redirect_to tasks_path, notice: "Task marked as completed."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed, :image)
  end
end
