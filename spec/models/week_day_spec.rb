require 'rails_helper'

describe WeekDay do
    describe 'validations' do
        it { should validate_presence_of :name }
        it { should validate_length_of :name }
    end
end
