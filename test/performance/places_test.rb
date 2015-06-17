require 'test_helper'
require 'rails/performance_test_help'

class PlacesTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 5, metrics: [:wall_time, :process_time, :objects]}
  #                         output: 'tmp/performance', formats: [:flat] }

  # def setup
  #   pub = Place.create!(name: "name", description: "description", phone: "456789123", email: "email@email.com")
  # end

  test "places_page" do
    get '/api/v1/places'
  end  

  test "place_show" do
    get '/api/v1/places/:id'
  end

  test "place_show_categories" do
    get '/api/v1/places/:id/categories'
  end

  # test "place_show_address" do
  #   get '/api/v1/places/:id/address'
  # end

  test "place_show_openinghours" do
    get '/api/v1/places/:id/opening_hours'
  end
end
