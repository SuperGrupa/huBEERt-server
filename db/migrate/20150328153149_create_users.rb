class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :login
      t.string :password
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.string :city

      t.timestamps
    end
  end
end
