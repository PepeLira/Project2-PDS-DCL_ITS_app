class AdminTeacher < ApplicationRecord
    has_secure_password
    has_many :problems, dependent: :destroy
end
