class City < ActiveRecord::Base
    has_many :districts

    validates :name, presence: true, length: { maximum: 30 }
end
