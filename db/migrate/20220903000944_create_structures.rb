class CreateStructures < ActiveRecord::Migration[7.0]
  def change
    create_table :structures do |t|
      t.string :moment_reference
      t.string :nodes_list
      t.string :segments_list
      t.string :struct_link
      t.string :force_values
      t.string :moment_values
      t.timestamps
    end
  end
end
