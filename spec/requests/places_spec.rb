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
                        expect(json['basic_info']['description']).to eq(@place.description)
                        expect(json['basic_info']['name']).to eq(@place.name)
                        expect(json['basic_info']['phone']).to eq(@place.phone)
                        expect(json['basic_info']['email']).to eq(@place.email)
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

            describe 'PATCH api/v1/places/:id' do
                before do
                    @place = Place.create! place_attributes
                end

                context 'with valid attributes' do
                    it 'updates a place' do
                        new_name = 'U Odyna'
                        patch "/api/v1/places/#{@place.id}", { name: new_name }

                        expect(json['name']).to eq(new_name)
                        expect(Place.find(@place.id).name).to eq(new_name)
                    end
                end

                context 'with invalid attributes' do
                    it 'returns an invalid email error' do
                        expect {
                            patch "/api/v1/places/#{@place.id}", { email: 'invalidemail' }
                        }.not_to change(Place, :count)

                        expect(json['error']).not_to eq(nil)
                    end
                end

                it 'unhides a place' do
                    put "/api/v1/places/#{@place.id}", { hidden: false }

                    expect(json['hidden']).to eq(false)
                    expect(Place.find(@place.id).hidden).to eq(false)
                end
            end

            describe 'DELETE api/v1/places/:id' do
                before do
                    @place = Place.create! place_attributes
                end

                it 'hides a place' do
                    delete "/api/v1/places/#{@place.id}"

                    expect(json['hidden']).to eq(true)
                    expect(Place.find(@place.id).hidden).to eq(true)
                end
            end
        end
    end
end
