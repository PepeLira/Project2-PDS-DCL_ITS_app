class RemoveTypeFromAnswer < ActiveRecord::Migration[7.0]
  def change
    remove_column :answers, :type
  end
end
