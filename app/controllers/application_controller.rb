class ApplicationController < ActionController::Base
    helper_method :logged_in?, :require_user
    
    def current_student
        @current_student ||= Student.find(session[:student_id]) if session[:student_id]
    end
    
    def logged_in?
        !!current_student
    end
    
    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action."
            redirect_to login_path
        end
    end
end

