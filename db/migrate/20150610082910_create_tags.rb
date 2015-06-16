class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :weight
      t.integer :searched

      t.timestamps null: false
    end
    
    create_table :places_tags do |t|
        t.belongs_to :place
        t.belongs_to :tag
    end
    
    add_index :places_tags, [:place_id, :tag_id], unique: true, name: 'places_tags_index'
  end
end
