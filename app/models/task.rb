class Task < ApplicationRecord
    belongs_to :problem
    has_one :student
end
