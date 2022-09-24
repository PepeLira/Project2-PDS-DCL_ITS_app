class TaskController < ApplicationController
  before_action :set_task

  def view
    
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
end
