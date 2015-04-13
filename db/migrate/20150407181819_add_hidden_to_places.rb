class AddHiddenToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :hidden, :boolean
  end
end
