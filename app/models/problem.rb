class Problem < ApplicationRecord
    belongs_to :admin_teacher
    belongs_to :structure
    has_one :task, dependent: :destroy
    has_many :steps, dependent: :destroy
    accepts_nested_attributes_for :structure
    has_one_attached :image, dependent: :destroy

    before_create :set_supports_points, :set_forces_points

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

    def get_supports_points
        self.extern_joins_points
    end


    def set_supports_points
        supports_count = structure.support_count
        builtin = structure.has_support?("empotrado")
        slider = structure.has_support?("deslizante")
        fixed = structure.has_support?("fijo")

        if builtin && slider && fixed
            if supports_count == 3
                @difficulty_b = 50
            elsif supports_count >= 8
                @difficulty_b = 100
            elsif supports_count > 3
                @difficulty_b = 50 + ((supports_count-3) * 10)
            end
        elsif builtin && slider || builtin && fixed || slider && fixed
            if supports_count == 2
                @difficulty_b = 30
            elsif supports_count >= 9
                @difficulty_b = 100
            elsif supports_count > 2
                @difficulty_b = 30 + ((supports_count-2) * 10)
            end
        elsif builtin || slider || fixed
            if supports_count >= 10
                @difficulty_b = 100
            else
                @difficulty_b = supports_count * 10
            end
            self.extern_joins_points = @difficulty_b
            
        end
    end

    def get_forces_points
        self.forces_moments_points
    end

    def set_forces_points
        if structure.count_forces_moments.present?
            forces_count = structure.count_forces_moments
            if forces_count >= 10
                @difficulty_f = 100
            end
            @difficulty_f = forces_count * 10
            self.forces_moments_points = @difficulty_f
        end
    end

    def make_xforce_ecuation()

    end

    def make_yforce_ecuation()

    end

    def make_moment_ecuation()

    end

end
