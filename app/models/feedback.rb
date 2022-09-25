class Feedback < ApplicationRecord
    belongs_to :answer
    has_one :response, dependent: :destroy
    
end
