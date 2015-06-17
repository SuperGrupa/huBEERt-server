class Address < ActiveRecord::Base
    include TagsHelper

    belongs_to :place
    belongs_to :street

    validates :number, presence: true
    validates :postcode, presence: true
    validates :postcode, format: { with: /\A[0-9]{2}-[0-9]{3}\z/ }
end
