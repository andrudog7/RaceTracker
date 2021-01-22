class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id, foreign_key: true 
      t.integer :friend_id, foreign_key: true 
      t.boolean :friendship, default: false 
      t.timestamps
    end
  end
end
