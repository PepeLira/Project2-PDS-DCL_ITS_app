class RemovePasswordFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :password
  end
end
