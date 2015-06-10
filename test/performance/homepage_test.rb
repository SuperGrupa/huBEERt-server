require 'test_helper'
require 'rails/performance_test_help'

class PlacesTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  # def setup
  #   pub = Place.create!(name: "name", description: "description", phone: "456789123", email: "email@email.com")
  # end

  test "placespage" do
    get '/api/v1/places'
  end
end
