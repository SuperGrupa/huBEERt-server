class Place < ActiveRecord::Base
    has_one :address
    has_many :opening_hours
    has_and_belongs_to_many :categories
    has_and_belongs_to_many :tags

    before_save :tagging

    EMAIL_FORMAT = /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i

    validates :name, presence: true, length: { maximum: 50 }
    validates :description, presence: true, length: { maximum: 500 }
    validates :email, format: { with: EMAIL_FORMAT }, allow_blank: true
    
    private
        
        def tagging
            if self.name_changed?
                name_tag = self.tags.find { |tag| tag.name == self.name_was } || Tag.new
                name_tag.name = self.name
                name_tag.save
                return true
            end
        end
end
