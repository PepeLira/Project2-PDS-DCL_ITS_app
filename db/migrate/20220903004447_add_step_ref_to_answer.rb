class AddStepRefToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :step, null: false, foreign_key: true
  end
end
