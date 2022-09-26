class StudentsController < ApplicationController
    before_action :set_student, only: %i[ show edit ]
    def index
        require_user
        @students = Student.all
    end
    
    def new
        @student = Student.new
    end

    def show
        require_user
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            flash[:notice] = "Student created."
            helpers.generate_next_task(@student)
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
      
        def set_student
            @student = Student.find(params[:id])
        end

        def student_params
            params.require(:student).permit(:full_name, :email, :password)
        end
end