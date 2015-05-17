require 'rails_helper'

module Api
  module AthenticationsRequests

    describe 'Authentication' do

      let(:json) { JSON.parse(response.body) }

      user_atrr = FactoryGirl.attributes_for(:user)

      describe "POST /api/v1/auth/register" do
        describe "with valid attributes" do
          it "should register a user" do
            expect {
              post "/api/v1/auth/register", user_atrr
            }.to change(User, :count).by(1)
          end
        end

        describe 'with invalid atributes' do
          it 'return a error' do
            @user = User.create! user_atrr
            expect {
              post "/api/v1/auth/register", user_atrr
            }.not_to change(User, :count)
            expect(json['error']).not_to eq(nil)
          end

          it 'return a email error' do
            expect {
              post "/api/v1/auth/register", {email: 'invalidemail', password: 'password'}
            }.not_to change(User, :count)
            expect(json['error']).not_to eq(nil)
          end

          it 'return a password error' do
            expect {
              post "/api/v1/auth/register", {email: 'valid@email.com', password: ' '}
            }.not_to change(User, :count)
            expect(json['error']).not_to eq(nil)
          end
        end
      end

      describe "POST /api/v1/auth/login" do
        before do
          @user = User.create! user_atrr
        end

        describe "with valid attributes" do
          it "should login a user" do
            post "/api/v1/auth/login", user_atrr
            expect(json['token']).not_to eq(nil)
            expect(json['email']).to eq(@user.email)
          end
        end

        describe 'with invalid atributes' do
          it 'return a email error' do
            post "/api/v1/auth/login", {email: 'invalidemail', password: 'password'}
            expect(json['error']).not_to eq(nil)
          end

          it 'return a login error' do
            post "/api/v1/auth/login", {login: 'invalidlogin', password: 'password'}
            expect(json['error']).not_to eq(nil)
          end

          it 'return a password error' do
            post "/api/v1/auth/login", {email: user_atrr[:email], password: 'invalid'}
            expect(json['error']).not_to eq(nil)
          end
        end
      end

      describe "DELETE /api/v1/auth/logut" do
        before do
          @user = User.create! user_atrr
          @token = @user.ensure_authentication_token(true)
        end

        it "should delete user token" do
          expect {
            delete "/api/v1/auth/logout", nil, {'Authorization' => @token.token}
          }.to change(AuthToken, :count).by(-1)
        end
      end

      describe "GET /api/v1/auth/check_token" do
        before do
          @user = User.create! user_atrr
          @token = @user.ensure_authentication_token(true)
        end

        it "returns a true" do
          get "/api/v1/auth/check_token", nil, {'Authorization' => @token.token}
          expect(response.body).to eq('true')
        end

        it "returns a false" do
          get "/api/v1/auth/check_token", nil, {'Authorization' => 'invalidToken'}
          expect(response.body).to eq('false')
        end
      end
    end
  end
end
