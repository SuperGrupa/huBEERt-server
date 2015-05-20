require 'rails_helper'

module Api
    module StreetsRequests
        describe 'Streets' do
            before do
                @city = FactoryGirl.create(:city)
                @district = @city.districts.create(name: 'Grunwald')
                @street = @district.streets.create(name: 'Pogodna')
            end
        
            let(:json) { JSON.parse(response.body) }

            describe 'getting streets list' do
                context 'GET api/v1/cities/:id/districts/:id/streets' do
                    it 'returns an array of streets' do
                        get "/api/v1/districts/#{@district.id}/streets"
                        expect(json.length).to be == 1
                        expect(json.first['id']).not_to be(nil)
                        expect(json.first['name']).to eq('Pogodna')
                    end
                end
            end
        end
    end
end
