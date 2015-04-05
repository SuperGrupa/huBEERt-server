require 'rails_helper'

module Api
    module PlacesRequests
        describe 'Places' do
            let(:json) { JSON.parse(response.body) }

            place_attributes = FactoryGirl.attributes_for :place

            describe 'getting place(s)' do
                before do
                    @place = Place.create! place_attributes
                end

                context 'GET api/v1/places' do
                    it 'returns one, created before place' do
                        get '/api/v1/places'
                        expect(json.length).to eq(1)
                    end
                end

                context 'GET api/v1/places/:id' do
                    it 'returns a place by id' do
                        get "/api/v1/places/#{@place.id}"
                        expect(json['description']).to eq(@place.description)
                        expect(json['name']).to eq(@place.name)
                        expect(json['phone']).to eq(@place.phone)
                        expect(json['email']).to eq(@place.email)
                    end
                end
            end


            describe 'POST api/v1/places' do
                context 'with valid attributes' do
                    it 'creates a new place' do
                        expect { post '/api/v1/places', place: place_attributes }.to change(Place, :count).by(1)
                    end
                end

                context 'with invalid attributes' do
                    it 'expects missing name error' do
                        expect { post '/api/v1/places', place: {description: 'Fajne miejsce'} }
                            .not_to change(Place, :count)
                        expect(json['error']).not_to eq(nil)
                    end

                    it 'expects missing description error' do
                        expect { post '/api/v1/places', place: {name: 'U Szwagra'}}
                            .not_to change(Place, :count)
                        expect(json['error']).not_to eq(nil)
                    end

                    it 'expects invalid email format error' do
                        expect {
                            post '/api/v1/places', place: {name: 'U Szwagra', description: 'Fajne miejsce',
                                                           email: 'invalidemail'}
                        }.not_to change(Place, :count)

                        expect(json['error']).not_to eq(nil)
                    end
                end
            end
        end
    end
end
