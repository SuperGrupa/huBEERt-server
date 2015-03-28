class OpeningHour < ActiveRecord::Base
    belongs_to :place
    has_and_belongs_to_many :week_days

    validates :from, presence: true, length: { maximum: 30 }
    validates :to, length: { maximum: 30 }
end
