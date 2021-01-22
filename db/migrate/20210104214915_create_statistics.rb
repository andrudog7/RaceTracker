class CreateStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :statistics do |t|
      t.time :finish_time
      t.time :finish_pace
      t.boolean :public
      t.belongs_to :race
      t.belongs_to :user

      t.timestamps
    end
  end
end
