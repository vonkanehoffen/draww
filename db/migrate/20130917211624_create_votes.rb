class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :direction
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
