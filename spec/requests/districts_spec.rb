require 'rails_helper'

module Api
    module DistrictsRequests
        describe 'Districts' do
            before do
                @city = FactoryGirl.create(:city)
                @district = @city.districts.create(name: 'Grunwald')
            end
        
            let(:json) { JSON.parse(response.body) }

            describe 'getting districts list' do
                context 'GET api/v1/cities/:id/districts' do
                    it 'returns an array of districts' do
                        get "/api/v1/cities/#{@city.id}/districts"
                        expect(json.length).to be == 1
                        expect(json.first['id']).not_to be(nil)
                        expect(json.first['name']).to eq('Grunwald')
                    end
                end
            end
        end
    end
end
