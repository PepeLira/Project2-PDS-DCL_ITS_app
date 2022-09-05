class Step < ApplicationRecord
    belongs_to :problem
    has_many :answers
    has_many :responses
end
