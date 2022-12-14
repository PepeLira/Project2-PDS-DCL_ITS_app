require 'json'
class Structure < ApplicationRecord
    belongs_to :admin_teacher
    has_many :problems, dependent: :destroy
    [:nodes_list, :segments_list, :moment_reference, :force_values].each do |v|
        validates v, presence: true
    end    

    def get_nodes_json
        JSON.load(nodes_list)
    end

    def get_segments_json
        segments_json = []
        JSON.load(segments_list).each do |segment|
            if segment["iType"].include?("Seg")
                segments_json.push(segment)
            end
        end
        
        segments_json
    end

    def get_forces_json
        JSON.load(force_values)
    end

    def get_moment_json
        JSON.load(moment_values)
    end

    def get_node(tag)
        get_nodes_json.each do |node|
            if node["nombre"] == tag
                return node
            end
        end
    end

    def count_forces_moments
        if get_forces_json.present?
            get_forces_json.length() + get_moment_json.length()
        end
    end

    def get_supports
        supports = []
        if get_nodes_json.present?
            get_nodes_json.each do |node|
                if ![3,5,4,0].include?(node["tipo"])
                    supports.push(node)
                end
            end
        end
        supports
    end

    def support_count
        if get_supports.present?
            get_supports.length
        end
    end

    def has_support?(type)
        if get_supports.present?
            if type == "empotrado"
                get_supports.each do |support|
                    if support["tipo"] == 1
                        return true
                    end
                end
            elsif type == "deslizante"
                get_supports.each do |support|
                    if support["tipo"] == 2
                        return true
                    end
                end
            elsif type == "fijo"
                get_supports.each do |support|
                    if (6..9).include?(support["tipo"])
                        return true
                    end
                end
            end
        end
        return false
    end
end
