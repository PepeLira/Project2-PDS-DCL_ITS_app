class Step < ApplicationRecord
    belongs_to :problem
    has_many :answers, dependent: :destroy
    has_many :responses, dependent: :destroy
end
