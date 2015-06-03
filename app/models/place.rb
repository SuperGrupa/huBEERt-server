class Place < ActiveRecord::Base
    has_one :address
    has_many :opening_hours
    has_and_belongs_to_many :categories

    EMAIL_FORMAT = /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i

    validates :name, presence: true, length: { maximum: 50 }
    validates :description, presence: true, length: { maximum: 500 }
    validates :email, format: { with: EMAIL_FORMAT }, allow_blank: true
end
