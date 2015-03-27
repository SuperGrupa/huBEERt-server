class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :number
      t.string :postcode
      t.references :place, index: true
      t.references :street, index: true

      t.timestamps
    end
  end
end
