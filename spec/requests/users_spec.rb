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
              post "/api/v1/users", user: {password: 'password'}
            }.not_to change(User, :count)
            expect(json['error']).not_to eq(nil)
          end

          it 'return a email error' do
            expect {
              post "/api/v1/users", user: {email: 'invalidemail', password: 'password'}
            }.not_to change(User, :count)
            expect(json['error']).not_to eq(nil)
          end

          it 'return a password error' do
            expect {
              post "/api/v1/users", user: {email: 'valid@email.com', password: ' '}
            }.not_to change(User, :count)
            expect(json['error']).not_to eq(nil)
          end
        end
      end

      describe "PATCH /api/v1/users/:id" do
        before do
          @user = User.create! user_atrr
        end

        describe 'with valid atributes' do
          it 'update a user' do
            atrr = "asd"
            patch "/api/v1/users/#{@user.id}", {email: user_atrr[:email], firstname: atrr}

            expect(json['firstname']).to eq(atrr)
            expect(User.find(@user.id).firstname).to eq(atrr)
          end
        end

        describe 'with invalid atributes' do
          it 'return a email error' do
            patch "/api/v1/users/#{@user.id}", user: {email: 'invalidemail'}
            expect(json['error']).not_to eq(nil)
          end

          it 'return a password error' do
            patch "/api/v1/users/#{@user.id}", user: {date_of_birth: 'asd'}
            expect(json['error']).not_to eq(nil)
          end
        end
      end

      describe "DELETE /api/v1/users/:id" do
        before do
          @user = User.create! user_atrr
        end

        it 'hides a user' do
          delete "/api/v1/users/#{@user.id}"

          expect(json['hidden']).to eq(true)
          expect(User.find(@user.id).hidden).to eq(true)
        end
      end

      describe "PUT /api/v1/users/:id" do
        before do
          @user = User.create! user_atrr
        end

        it 'unhides a user' do
          put "/api/v1/users/#{@user.id}"

          expect(json['hidden']).to eq(false)
          expect(User.find(@user.id).hidden).to eq(false)
        end
      end

      describe "POST /api/v1/users/check_email" do
        before do
          @user = User.create! user_atrr
        end

        describe 'with valid atributes' do
          it 'return "true"' do
            post "/api/v1/users/check_email", {email: user_atrr[:email]}
            expect(response.body).to eq("false")
          end

          it 'return "false"' do
            post "/api/v1/users/check_email", {email: 'asd'}
            expect(response.body).to eq("true")
          end
        end

        describe 'with invalid atributes' do
          it 'return a nil' do
            post "/api/v1/users/check_email", {email: 123}
            expect(response.body).not_to eq(nil)
          end
        end
      end

      describe "POST /api/v1/users/check_login" do
        before do
          @user = User.create! user_atrr
        end

        describe 'with valid atributes' do
          it 'return "true"' do
            post "/api/v1/users/check_login", {login: user_atrr[:login]}
            expect(response.body).to eq("false")
          end

          it 'return "false"' do
            post "/api/v1/users/check_login", {login: 'asd'}
            expect(response.body).to eq("true")
          end
        end

        describe 'with invalid atributes' do
          it 'return a nill' do
            post "/api/v1/users/check_login", {login: 123}
            expect(response.body).not_to eq(nil)
          end
        end
      end
    end
  end
end

#expect(response.body).to eq('user[password] is empty')
