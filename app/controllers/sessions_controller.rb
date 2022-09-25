class SessionsController < ApplicationController
    def create
        student = Student.find_by(email: params[:session][:email].downcase)
        if student && student.authenticate(params[:session][:password])
          session[:student_id] = student.id
          flash[:notice] = "Logged in successfully."
          redirect_to root_path
        else
          flash.now[:alert] = "There was something wrong with your login details."
          render 'new'
        end
    end
       
    def destroy
        session[:student_id] = nil
        flash[:notice] = "You have been logged out."
        redirect_to root_path
    end
end