require 'rails_helper'

describe OpeningHour do
    describe 'validations' do
        it { should validate_presence_of :from }
        it { should validate_length_of :from }
        it { should validate_length_of :to }
    end
end
