class Structure < ApplicationRecord
    belongs_to :admin_teacher, :through => :problem
    has_many :problems

end
