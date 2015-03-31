class Street < ActiveRecord::Base
    belongs_to :district
    has_many :addresses

    validates :name, presence: true, length: { maximum: 50 }
end
