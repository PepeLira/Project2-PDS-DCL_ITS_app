class Problem < ApplicationRecord
    belongs_to :admin_teacher
    belongs_to :structure
    has_one :task
    has_many :steps
end
