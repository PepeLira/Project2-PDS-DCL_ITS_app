class CreateProblems < ActiveRecord::Migration[7.0]
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.integer :extern_joins_points
      t.integer :forces_moments_points
      t.integer :con_rod_points
      t.integer :ball_joint_points

      t.timestamps
    end
  end
end
