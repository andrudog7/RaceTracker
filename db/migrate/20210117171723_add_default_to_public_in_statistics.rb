class AddDefaultToPublicInStatistics < ActiveRecord::Migration[6.1]
  def change
    change_column :statistics, :public, :boolean, :default => true
  end
end
