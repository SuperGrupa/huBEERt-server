require 'test_helper'
require 'rails/performance_test_help'

class UsersModelTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 5, metrics: [:wall_time, :objects]}
  #                          output: 'tmp/performance', formats: [:flat] }

  test "user_creation" do
    user = User.create!( email: "email@email.com", login: "login", firstname: "firstname", lastname: "lastname", 
    											date_of_birth: "1978-10-16", city: "city", password: "password")
  end

  test "user_deletion" do
  	delete "/api/v1/users/:id"
  end

  test "user_editname" do
    patch '/api/v1/users/:id' do
        user = User.find(:id)
        user.update(name: "newname")
        user
    end
  end

  test "user_edithide" do
    delete '/api/v1/users/:id' do
      user = User.find(:id)
      user.update(hidden: true)
      user
    end
  end

  test "user_checklogin" do
    post '/api/v1/users/check_login' do
      if User.where(login: "login").blank?
        true
      else
        false
      end
    end
  end
  
end
