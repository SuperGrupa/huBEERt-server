class CreateCategory < ActiveRecord::Migration
    def change
        create_table :categories do |t|
            t.string :name
        end
        
        create_table :places_categories do |t|
            t.belongs_to :place
            t.belongs_to :category
        end

        add_index :places_categories, [:place_id, :category_id], unique: true,
                                            name: 'places_categories_index'
    end
end
