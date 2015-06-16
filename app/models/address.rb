class Address < ActiveRecord::Base
    include TagsHelper

    belongs_to :place
    belongs_to :street
    
    after_save :tag_address

    validates :number, presence: true
    validates :postcode, presence: true
    validates :postcode, format: { with: /\A[0-9]{2}-[0-9]{3}\z/ }
    
    private

        def tag_address
            self.street.name.split(" ").each do |text|
                tagging(self.place_id, current:  text,
                                       previous: self.street.name_was, 
                                       weight:   8)
            end
            
            self.street.district.name.split(" ").each do |text|
                tagging(self.place_id, current:  self.street.district.name,
                                       previous: self.street.district.name_was,
                                       weight:   6)
            end
            
            self.street.district.city.name.split(" ").each do |text|
                tagging(self.place_id, current:  self.street.district.city.name,
                                       previous: self.street.district.city.name_was,
                                       weight:   4)
            end
        end
end
