require 'rails_helper'

describe Place do
    describe 'validations' do
        it { should validate_presence_of :name }
        it { should validate_length_of :name }
        it { should validate_presence_of :description }
        it { should validate_length_of :description }
        it { should allow_value('john.doe@abcdef.ghi.com').for(:email) }
        it { should_not allow_value('john.doe@abcdef...com').for(:email) }
        it { should_not allow_value('john.doe@abcdef.ghicom').for(:email) }
    end
end
