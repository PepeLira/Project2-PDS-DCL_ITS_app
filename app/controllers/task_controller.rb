class TaskController < ApplicationController
  before_action :require_user
  before_action :set_task, only: %i[ view ]

  def view
    @problem = @task.problem
    get_steps
  end

  def index
    @tasks = Task.where(student_id: current_student.id)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def get_steps
    @steps = Step.where(problem_id: @task.problem_id)
    @steps 
  end
end