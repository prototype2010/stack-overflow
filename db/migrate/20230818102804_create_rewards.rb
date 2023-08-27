class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.string :description
      t.belongs_to :rewardable, polymorphic: true
      t.timestamps
    end
  end
end
