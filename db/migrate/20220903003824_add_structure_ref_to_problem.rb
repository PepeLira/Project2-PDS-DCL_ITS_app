class AddStructureRefToProblem < ActiveRecord::Migration[7.0]
  def change
    add_reference :problems, :structure, null: false, foreign_key: true
  end
end
