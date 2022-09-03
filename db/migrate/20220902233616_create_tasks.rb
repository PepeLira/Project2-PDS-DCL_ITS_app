class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :extern_joins_exp
      t.integer :forces_moments_exp
      t.integer :con_rod_exp
      t.integer :ball_joint_exp

      t.timestamps
    end
  end
end
