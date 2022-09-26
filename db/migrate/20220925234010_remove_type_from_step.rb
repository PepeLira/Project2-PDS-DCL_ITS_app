class RemoveTypeFromStep < ActiveRecord::Migration[7.0]
  def change
    remove_column :steps, :type
  end
end
