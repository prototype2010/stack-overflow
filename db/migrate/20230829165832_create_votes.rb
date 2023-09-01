class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.timestamps
      t.belongs_to :votable, polymorphic: true
      t.references :author, null: false, foreign_key: { to_table: :users }
    end
  end
end
