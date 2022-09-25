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


    def get_supports_points
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
            extern_joins_points = @difficulty_b
            
        end
    end

    def get_forces_points
        forces_count = structure.count_forces_moments
        if forces_count >= 10
            @difficulty_f = 100
        end
        @difficulty_f = forces_count * 10
        forces_moments_points = @difficulty_f
    end

    def obtain_support_forces(x_or_y)
        supports = structure.get_supports()
        xy_forces = []
        supports.each do |support|
            if support["tipo"] == 1 #empotrado
                xy_forces.push(support)
            elsif support["tipo"] == 2
                if x_or_y == 'y'
                    xy_forces.push(support) #deslizante
                end
            elsif (6..9).include?(support["tipo"]) #fijo
                xy_forces.push(support)
            end
        end
        xy_forces
    end

    def xy_force_vectors(x_or_y)
        xy_force_vectors = structure.get_forces_json()
        x_forces = []
        y_forces = []
        xy_force_vectors.each do |xy_force|
            if x_or_y == 'x'
                if xy_force != null
                    x_forces.push(xy_force.Magnitud_o_distancia * Math.cos(xy_force.Angulo))
                end
            elsif x_or_y == 'y'
                if xy_force != null
                    y_forces.push(xy_force.Magnitud_o_distancia * Math.sin(xy_force.Angulo))
                end
            end
        end
        if x_or_y == 'x'
            return x_forces
        elsif x_or_y == 'y'
            return y_forces
        end
    end

    def make_xforce_ecuation()        
        x_support_forces = obtain_support_forces('x') #nombrarlas segun el nodo ej: cx, fx, dx
        x_force_vectors = xy_force_vectors('x')
    end

    def make_yforce_ecuation()
        y_support_forces = obtain_support_forces('y') #nombrarlas segun el nodo ej: cy, fy, dy
        y_force_vectors = xy_force_vectors('y')
    end

    def make_moment_ecuation()

    end

end
