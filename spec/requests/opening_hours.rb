require 'rails_helper'

module Api
    module OpeningHoursRequests
        describe 'Opening hours' do
            before do                
                @place = FactoryGirl.create(:place)
                @place.opening_hours.create!(from: '17:00', to: '23:00')
            end

            let(:json) { JSON.parse(response.body) }

            describe 'getting opening hours' do
                context 'GET api/v1/places/:id/opening_hours' do
                    it 'returns array of opening hours for prevoiusly created place' do
                        get "/api/v1/places/#{@place.id}/opening_hours"
                        expect(json.length).to be >= 1
                        expect(json.first['from']).not_to be(nil)
                    end
                end
            end

            #describe 'POST api/v1/places/:id/opening_hours' do
            #    context 'with valid attributes' do
            #        it 'creates a new opening_hours for place' do
            #            expect {
            #                post "/api/v1/places/#{@place.id}/opening_hours",
            #                opening_hours: { from: '17:00', to: '23:00', days: [{ id: 1 }] }
            #            }.to change(OpeningHour, :count).by(1)
            #        end
            #    end
            #    
            #    context 'with invalid attributes' do
            #        it 'missing from' do
            #            expect {
            #                post "/api/v1/places/#{@place.id}/opening_hours", address: { number: '1' }
            #            }.not_to change(Address, :count)
            #            expect(json['error']).not_to eq(nil)
            #        end
            #        it 'missing info' do
            #            expect {
            #                post "/api/v1/places/#{@place.id}/address", address: { postcode: '60-150' }
            #            }.not_to change(Address, :count)
            #            expect(json['error']).not_to eq(nil)
            #        end
            #        it 'expects invalid street format error' do
            #            expect {
            #                post "/api/v1/places/#{@place.id}/address",
            #                    address: { postcode: '60-150', street: { number: '1', test: '1' } }
            #            }.not_to change(Address, :count)
            #            expect(json['error']).not_to eq(nil)
            #        end
            #    end
            #end
        end
    end
end

