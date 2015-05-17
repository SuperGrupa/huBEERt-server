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

  describe 'tokens' do
    before do
      @user = User.create! user_atrr
    end

    describe 'generate_authentication_token method' do
      it 'should generate token' do
        token = @user.send(:generate_authentication_token)
        expect(token).not_to eq(nil)
      end
    end

    describe 'ensure_authentication_token method' do
      it 'should generate AuthToken model' do
        expect {
          @user.ensure_authentication_token(true)
        }.to change(AuthToken, :count).by(1)
      end
    end
  end
end
