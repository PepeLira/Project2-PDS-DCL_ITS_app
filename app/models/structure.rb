class Structure < ApplicationRecord
    belongs_to :admin_teacher
    has_many :problems

end
