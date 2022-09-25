class Student < ApplicationRecord
    has_secure_password
    has_many :tasks, dependent: :destroy

    before_create :set_stats

    private
    def set_stats
        self.extern_joins_stat = 0
        self.forces_moments_stat = 0
        self.con_rod_stat = 0
        self.ball_joint_stat = 0
    end
end

