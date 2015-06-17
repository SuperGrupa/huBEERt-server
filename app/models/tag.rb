class Tag < ActiveRecord::Base
    has_and_belongs_to_many :places
    
    validates :name, presence: true
    validates :weight, presence: true, numericality: { only_integer: true, greater_than: 0, less_or_equal_to: 10 }
    validates :searched, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
