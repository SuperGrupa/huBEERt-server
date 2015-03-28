class District < ActiveRecord::Base
    belongs_to :city
    has_many :streets

    validates :name, presence: true, length: { maximum: 30 }
end
