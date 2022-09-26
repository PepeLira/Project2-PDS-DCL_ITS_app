class TaskController < ApplicationController
  before_action :require_user
  before_action :set_task, only: %i[ view represent_step dcl_step equation_step ]
  before_action :get_steps, only: %i[ view represent_step dcl_step equation_step ]

  def view
    @problem = @task.problem
  end

  def index
    @tasks = Task.where(student_id: current_student.id)
  end

  def represent_step
    @problem = @task.problem
    @structure = Structure.new
  end

  def dcl_step
    @problem = @task.problem
  end 

  def equation_step
    @problem = @task.problem
    @new_response = Response.new
  end

  def equation_step_post_version

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