class Answer < ApplicationRecord
    belongs_to :step
    has_many :feedbacks, dependent: :destroy
end
