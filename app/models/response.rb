class Response < ApplicationRecord
    belongs_to :step
    has_one :step
end
