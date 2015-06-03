class CreateCategories < ActiveRecord::Migration
    def change
        create_table :categories do |t|
            t.string :name
        end
        
        create_table :categories_places do |t|
            t.belongs_to :place
            t.belongs_to :category
        end

        add_index :categories_places, [:place_id, :category_id], unique: true,
                                            name: 'categories_places_index'
    end
end
