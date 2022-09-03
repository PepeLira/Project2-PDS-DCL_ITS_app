class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :email
      t.string :full_name
      t.string :password
      t.integer :extern_joins_stat
      t.integer :forces_moments_stat
      t.integer :con_rod_stat
      t.integer :ball_joint_stat

      t.timestamps
    end
  end
end
