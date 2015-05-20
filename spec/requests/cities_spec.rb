require 'rails_helper'

module Api
    module CitiesRequests
        describe 'Cities' do
            before do
                @city = FactoryGirl.create(:city, name: 'BartasCity')
            end
        
            let(:json) { JSON.parse(response.body) }

            describe 'getting cities list' do
                context 'GET api/v1/cities' do
                    it 'returns an array of cities' do
                        get '/api/v1/cities'
                        expect(json.length).to be == 1
                        expect(json.first['id']).not_to be(nil)
                        expect(json.first['name']).to eq('BartasCity')
                    end
                end
            end
        end
    end
end
