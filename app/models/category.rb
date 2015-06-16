class Category < ActiveRecord::Base
    include TagsHelper

    has_and_belongs_to_many :places

    after_save :tag_category

    validates :name, presence: true
    
    private
    
        def tag_category
            self.name.split(" ").each do |text|
                tagging(self.place_id, current: text, previous: self.name_was, weight: 4)
            end
        end
    
end

