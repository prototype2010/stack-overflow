class AddUserIdToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :author, foreign_key: { to_table: :users }, null: false, default: User.first.id
  end
end
