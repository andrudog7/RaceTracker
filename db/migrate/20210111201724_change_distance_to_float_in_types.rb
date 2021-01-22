class ChangeDistanceToFloatInTypes < ActiveRecord::Migration[6.1]
  def change
    change_column :types, :distance, 'decimal USING distance::numeric'
  end
end
