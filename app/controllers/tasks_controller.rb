class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  before_action :check_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.paginate(page: params[:page], per_page: 10)
  end

  def complete_task
    @tasks = current_user.tasks.paginate(page: params[:page], per_page: 10)
  end

  def not_complete_task
    @tasks = current_user.tasks.paginate(page: params[:page], per_page: 10)
  end

  def week_task
    @tasks = Task.order(:due_date)
    @task_months = @tasks.where('due_date >= ? AND due_date <= ? AND user_id = ?', Time.current.beginning_of_week, Time.current.end_of_week, current_user.id)
  end


  def show
  end


  def new
    @task = Task.new
  end


  def edit
  end


  def create
    @task = Task.new(task_params)
    @task.user = current_user
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :status, :due_date)
    end

    def check_user
      if current_user != @task.user
        flash[:danger] = "You can only edit or delete your own tasks"
        redirect_to tasks_path
      end
    end
end
