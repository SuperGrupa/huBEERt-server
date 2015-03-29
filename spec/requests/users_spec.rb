require 'rails_helper'

module Api
  module UsersRequests

    describe 'Users' do

      let(:json) { JSON.parse(response.body) }

      user_atrr = FactoryGirl.attributes_for(:user)

      describe "GET /api/v1/users" do
        before do
          @user = User.create! user_atrr
        end

        it "returns an empty array of entries" do
          get "/api/v1/users"
          expect(json.length).to eq(1)
        end
      end

      describe "GET /api/v1/users/:id" do
        before do
          @user = User.create! user_atrr
        end

        it "returns a user by id" do
          get "/api/v1/users/#{@user.id}"
          expect(json['email']).to eq(@user.email)
        end
      end

      describe "POST /api/v1/users" do
        describe 'with valid atributes' do
          it 'creates a new user' do
            expect {
              post "/api/v1/users", user: user_atrr
            }.to change(User, :count).by(1)
          end
        end

        describe 'with invalid atributes' do
          it 'return a email error' do
            expect {
              post "/api/v1/users", user: {email: 'invalidemail', password: 'password'}
            }.not_to change(User, :count)
            expect(json['error']).to eq('user[email] is invalid')
          end

          it 'return a password error' do
            expect {
              post "/api/v1/users", user: {email: 'valid@email.com', password: ' '}
            }.not_to change(User, :count)
            expect(json['error']).to eq('user[password] is empty')
          end
        end
      end
    end
  end
end
