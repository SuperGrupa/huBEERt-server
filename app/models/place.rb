class Place < ActiveRecord::Base
    include PlacesHelper
    include TagsHelper

    has_one :address
    has_many :opening_hours
    has_and_belongs_to_many :categories, after_add: :tag_category
    has_and_belongs_to_many :tags

    after_save :tag_name

    EMAIL_FORMAT = /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i

    validates :name, presence: true, length: { maximum: 50 }
    validates :description, presence: true, length: { maximum: 500 }
    validates :email, format: { with: EMAIL_FORMAT }, allow_blank: true
    
    private
        
        def tag_name
            if self.name_changed?
                tagging(self.id, current: self.name, previous: self.name_was, weight: 10)
            end
        end
        
        def tag_category(category)
            tagging(self.id, current: category.name, previous: category.name_was, weight: 4)
        end
end
