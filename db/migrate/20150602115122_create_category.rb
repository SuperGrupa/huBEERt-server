class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :place, index: true, foreign_key: true
    end
  end
end
