require 'test_helper'
require 'rails/performance_test_help'

class UsersTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 5, metrics: [:wall_time, :process_time, :objects]}
  #                          output: 'tmp/performance', formats: [:flat] }


  test "users_page" do
    get '/api/v1/users'
  end  

  test "user_show" do
    get '/api/v1/users/:id'
  end
end
