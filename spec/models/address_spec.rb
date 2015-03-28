require 'rails_helper'

RSpec.describe Address, :type => :model do
    describe 'validations' do
        it { should validate_presence_of :postcode }
    end
end
