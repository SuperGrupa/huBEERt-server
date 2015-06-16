require 'test_helper'
require 'rails/performance_test_help'

class PlaceModelTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 5, metrics: [:wall_time, :objects]}
  #                          output: 'tmp/performance', formats: [:flat] }

  test "place_creation" do
    pub = Place.create!(name: "name", description: "description", phone: "456789123", email: "email@email.com")
  end

  test "place_deletion" do
  	delete "/api/v1/places/:id"
  end

  test "place_editname" do
    patch '/api/v1/places/:id' do
        place = Place.find(:id)
        place.update(name: "newname")
        place
    end
  end

  test "place_editunhide" do
    put '/api/v1/places/:id' do
	    place = Place.find(:id)
        place.update(hidden: false)
        place
    end
  end
end
