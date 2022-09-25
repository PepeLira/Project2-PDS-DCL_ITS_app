class SessionsController < ApplicationController
  def create
    student = Student.find_by(email: params[:session][:email].downcase)
    admin_teacher = AdminTeacher.find_by(email: params[:session][:email].downcase)
    if student && student.authenticate(params[:session][:password]) 
      session[:student_id] = student.id
      flash[:notice] = "Logged in successfully."
      redirect_to "/tasks/index"
    elsif admin_teacher && admin_teacher.authenticate(params[:session][:password])
      session[:admin_teacher_id] = admin_teacher.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_url
    else
      flash.now[:alert] = "There was something wrong with your login details."
      render 'new'
    end
  end
      
  def destroy
      session[:student_id] = nil
      session[:admin_teacher_id] = nil
      flash[:notice] = "You have been logged out."
      redirect_to root_path
  end
end