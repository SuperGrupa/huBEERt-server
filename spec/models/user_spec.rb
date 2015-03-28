require 'rails_helper'

RSpec.describe User, type: :model do

  user_atrr = FactoryGirl.attributes_for(:user)

  describe 'validations' do
    before do
      @user = User.create! user_atrr
    end

    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it 'when #email format is not valid' do
      @user.email = 'invalid mail'
      expect(@user).not_to be_valid
    end

    it 'when #email format is valid' do
      @user.email = 'valid@mail.com'
      expect(@user).to be_valid
    end

    it 'when #email is not unique' do
      @user1 = User.create user_atrr
      expect(@user1).not_to be_valid
    end

  end
end
