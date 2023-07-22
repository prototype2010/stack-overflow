class AddIndexToQuestionTitle < ActiveRecord::Migration[7.0]
  def change
    add_index  :questions, :title
  end
end
