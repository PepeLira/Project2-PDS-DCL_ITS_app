class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
