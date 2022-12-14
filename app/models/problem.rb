class Problem < ApplicationRecord
    belongs_to :admin_teacher
    belongs_to :structure
    has_one :task, dependent: :destroy
    has_many :steps, dependent: :destroy
    accepts_nested_attributes_for :structure
    has_one_attached :image, dependent: :destroy

    before_create :set_stats, :set_supports_points, :set_forces_points

    after_create :set_answers

    def set_answers
        Answer.create(step_id: @step1, content: (self.structure_id+1).to_s, answer_type: "a_structure_id")
        step3_xforces = [obtain_support_forces("x"),xy_force_vectors("x")].to_json
        step3_yforces = [obtain_support_forces("y"),xy_force_vectors("y")].to_json

        Answer.create(step_id: @step3, content: step3_xforces, answer_type: "xforces")
        Answer.create(step_id: @step3, content: step3_yforces, answer_type: "yforces")
        Answer.create(step_id: @step3, content: self.structure.get_moment_json, answer_type: "moment")
        Answer.create(step_id: @step4, content: make_xforce_ecuation, answer_type: "xforce")
        Answer.create(step_id: @step4, content: make_yforce_ecuation, answer_type: "yforce")
        Answer.create(step_id: @step4, content: make_moment_ecuation, answer_type: "moment_ecuation")
    end

    
    def step1=(step1)
        @step1 = step1
    end

    def step1
        @step1
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
            self.extern_joins_points = @difficulty_b
        elsif builtin && slider || builtin && fixed || slider && fixed
            if supports_count == 2
                @difficulty_b = 30
            elsif supports_count >= 9
                @difficulty_b = 100
            elsif supports_count > 2
                @difficulty_b = 30 + ((supports_count-2) * 10)
            end
            self.extern_joins_points = @difficulty_b
        elsif builtin || slider || fixed
            if supports_count >= 10
                @difficulty_b = 100
            else
                @difficulty_b = supports_count * 10
            end
            self.extern_joins_points = @difficulty_b
        else
            self.extern_joins_points = 0
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
        xy_forces = structure.get_forces_json()
        all_supports = structure.get_supports()
        nod_ref = structure.moment_reference
        pr_nodes = structure.get_nodes_json()
        dist_to_momentx = 0
        dist_to_momenty = 0
        all_support_m = []
        moment_xy = []

        nod_ref = pr_nodes.find{|e| e['nombre'] == nod_ref}

        xy_moments.each do |m|
            moment_xy.push(m['magnitude'].to_s)
        end

        xy_forces.each do |f|
            ss = f['iType'][7..7]
            cur_moment_node = pr_nodes.find{|e| e['nombre'] == ss}
            dist_to_momentx = (nod_ref['x'] - cur_moment_node['x']).abs
            dist_to_momenty = (nod_ref['y'] - cur_moment_node['y']).abs
            if dist_to_momentx == 0
                moment_xy.push('(' + f['Magnitud_o_distancia'].to_s + ' * ' + dist_to_momenty.to_s + ')')
            elsif dist_to_momenty == 0
                moment_xy.push('(' + f['Magnitud_o_distancia'].to_s + ' * ' + dist_to_momentx.to_s + ')')
            elsif dist_to_momentx != 0 && dist_to_momenty != 0
                moment_xy.push('(' + f['Magnitud_o_distancia'].to_s + ' * ' + (dist_to_momentx + dist_to_momenty).to_s + ')')
            end
        end

        all_supports.each do |sup|
            dist_to_momentx = (nod_ref['x'] - sup['x']).abs
            dist_to_momenty = (nod_ref['y'] - sup['y']).abs
            if dist_to_momentx == 0
                moment_xy.push('(' + dist_to_momenty.to_s + ' * ' + sup['nombre'] + 'y' + ')')
            elsif dist_to_momenty == 0
                moment_xy.push('(' + dist_to_momentx.to_s + ' * ' + sup['nombre'] + 'x' +')')
            elsif dist_to_momentx != 0 && dist_to_momenty != 0
                moment_xy.push('(' + dist_to_momentx.to_s + ' * ' + sup['nombre'] + 'x' + ' + ' + dist_to_momenty.to_s + sup['nombre'] + 'y' + ')')
            end
        end

        moment_for_view = ''
        moment_xy.each do |m|
            moment_for_view += ' + ' + m
        end
        moment_for_view
    end

    private
    def set_stats
        self.extern_joins_points = 0
        self.forces_moments_points = 0
        self.con_rod_points = 0
        self.ball_joint_points = 0
    end

end
