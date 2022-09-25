class StudentsController < ApplicationController
    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            flash[:notice] = "Student created."
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        if logged_in?

        else

        end
    end
      
    private
      
    def student_params
        params.require(:student).permit(:full_name, :email, :password)
    end
end