class ApplicationController < ActionController::Base
    
    @admin_teachers = AdminTeacher.all
end

