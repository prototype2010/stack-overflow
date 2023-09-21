class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :subscriptionable, polymorphic: true
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
