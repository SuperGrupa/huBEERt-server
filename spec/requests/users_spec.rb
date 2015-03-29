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
    end
  end
end
