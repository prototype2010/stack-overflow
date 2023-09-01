class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :commentable, polymorphic: true
      t.timestamps
      t.references :author, null: false, foreign_key: { to_table: :users }
    end
  end
end
