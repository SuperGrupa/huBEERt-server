class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
