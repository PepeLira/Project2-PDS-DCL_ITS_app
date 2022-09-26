class AddStepTypeToStep < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :step_type, :string
  end
end
