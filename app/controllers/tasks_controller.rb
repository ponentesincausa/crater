class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, except: [:index, :new, :create]

  def index
    @tasks = @project.tasks.all.order(priority: :desc)
    @completed = @tasks.completed
  end

  def show
    @task = set_task
    @comments = @task.comments.all
  end

  def new
    @task = Task.new
  end

  def edit

  end

  def create

    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to @project, notice: 'Task was successfully saved'
    else
      render :new
    end
  end

  def update
      if @task.update(task_params)
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    if @task.destroy
      flash[:success] = "Task was deleted."
    else
      flash[:error] = "Task could not be deleted."
    end
    redirect_to @project
  end

  def complete
    @task.update_attribute(:completed, Date.today)
    redirect_to @project, notice: 'Task completed'
  end

  private

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :deadline, :project_id, :priority)
  end
end
