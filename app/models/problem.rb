class Problem < ApplicationRecord
    belongs_to :admin_teacher
    belongs_to :structure
    has_one :task, dependent: :destroy
    has_many :steps, dependent: :destroy
    accepts_nested_attributes_for :structure
    has_one_attached :image, dependent: :destroy

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
        if structure.count_forces_moments.present?
            forces_count = structure.count_forces_moments
            if forces_count >= 10
                @difficulty_f = 100
            end
            @difficulty_f = forces_count * 10
            forces_moments_points = @difficulty_f
        end
    end

    def obtain_support_forces(x_or_y)
        supports = structure.get_supports()
        xy_forces = []
        supports.each do |support|
            if support["tipo"] == 1 #empotrado
                xy_forces.push(support['nombre']+x_or_y)
            elsif support["tipo"] == 2
                if x_or_y == 'y'
                    xy_forces.push(support['nombre']+x_or_y) #deslizante
                end
            elsif (6..9).include?(support["tipo"]) #fijo
                xy_forces.push(support['nombre']+x_or_y)
            end
        end #filtrar en x e y y concatenar el x al nombre del punto o el y
        xy_forces
    end

    def obtain_support_forces(x_or_y)
        supports = structure.get_supports()
        xy_forces = []
        supports.each do |support|
            if support["tipo"] == 1 #empotrado
                xy_forces.push(support['nombre']+x_or_y)
            elsif support["tipo"] == 2
                if x_or_y == 'y'
                    xy_forces.push(support['nombre']+x_or_y) #deslizante
                end
            elsif (6..9).include?(support["tipo"]) #fijo
                xy_forces.push(support['nombre']+x_or_y)
            end
        end #filtrar en x e y y concatenar el x al nombre del punto o el y
        xy_forces
    end

    def xy_force_vectors(x_or_y)
        xy_force_vectors = structure.get_forces_json()
        x_forces = []
        y_forces = []
        xy_force_vectors.each do |xy_force|
            if x_or_y == 'x'
                if xy_force['Angulo'] != nil
                    x_forces.push(xy_force['Magnitud_o_distancia'].to_s + ' * ' + 'cos(' + xy_force['Angulo'].to_s + ')')
                end
            elsif x_or_y == 'y'
                if xy_force['Angulo'] != nil
                    y_forces.push(xy_force['Magnitud_o_distancia'].to_s + ' * ' + 'sin(' + xy_force['Angulo'].to_s + ')')
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
        x_support_forces = obtain_support_forces('x')
        x_force_vectors = xy_force_vectors('x')
        total_forces = x_support_forces + x_force_vectors
        forces_for_the_view = ''
        total_forces.each do |f|
            forces_for_the_view += ' + ' + f
        end
        forces_for_the_view
    end

    def make_yforce_ecuation()
        y_support_forces = obtain_support_forces('y')
        y_force_vectors = xy_force_vectors('y')
        total_forces = y_support_forces + y_force_vectors
        forces_for_the_view = ''
        total_forces.each do |f|
            forces_for_the_view += ' + ' + f
        end
        forces_for_the_view
    end

    def make_moment_ecuation()
        xy_moments = structure.get_moment_json()
        dist_to_moment = 0
        nod_ref = structure.moment_reference
        pr_nodes = structure.get_nodes_json()

        #nod_ref = pr_nodes.find{|e| e['nombre'] == nod_ref}

        xy_moments.each do |m|
            #find the nodes and compare distances to multiply
            cur_moment_node = pr_nodes.find{|e| e['nombre'] == m['nombre']}
            x_pos = cur_moment_node['x']
            y_pos = cur_moment_node['y']
            m['magnitude'] = nod_ref
        end
        xy_moments
    end

end
