class WeekDay < ActiveRecord::Base
    has_and_belongs_to_many :opening_hours

    validates :name, presence: true, length: { maximum: 20 }
end
