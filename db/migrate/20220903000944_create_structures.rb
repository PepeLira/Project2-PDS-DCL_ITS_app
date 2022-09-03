class CreateStructures < ActiveRecord::Migration[7.0]
  def change
    create_table :structures do |t|
      t.string :moment_reference

      t.timestamps
    end
  end
end
