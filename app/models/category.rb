class Category < ActiveRecord::Base
    has_and_belongs_to_many :places

    validates :name, presence: true
end

