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
            unless self.place_id.nil?
                if self.street.name_changed?
                    tagging(self.place_id, current: self.street.name, previous: self.street.name_was, weight: 8)
                end
                
                if self.street.district.name_changed?
                    tagging(self.place_id, current:  self.street.district.name,
                                           previous: self.street.district.name_was,
                                           weight:   6)
                end
                
                if self.street.district.city.name_changed?
                    tagging(self.place_id, current:  self.street.district.city.name,
                                           previous: self.street.district.city.name_was,
                                           weight:   4)
                end
            end
        end
end
