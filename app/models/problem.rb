class Problem < ApplicationRecord
    belongs_to :admin_teacher
    belongs_to :structure
    has_one :task
    has_many :steps
    accepts_nested_attributes_for :structure
    has_one_attached :image

    def step1=(step1)
        @step1 = step1
    end

    def step1
        @step1
    end

    def step2=(step2)
        @step2 = step2
    end

    def step2
        @step2
    end

    def step3=(step3)
        @step3 = step3
    end

    def step3
        @step3
    end

    def step4=(step4)
        @step4 = step4
    end

    def step4
        @step4
    end

end
