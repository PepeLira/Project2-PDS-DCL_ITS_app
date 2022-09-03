class AddAnswerRefToFeedback < ActiveRecord::Migration[7.0]
  def change
    add_reference :feedbacks, :answer, null: false, foreign_key: true
  end
end
