class AddPublicToRaces < ActiveRecord::Migration[6.1]
  def change
    add_column :races, :public, :boolean, :default => true
  end
end
