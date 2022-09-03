class Step < ApplicationRecord
    belongs_to :task, :through => :problem
    has_many :answers
    has_many :responses
end
