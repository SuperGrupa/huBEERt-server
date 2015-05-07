require 'rails_helper'

module Api
    module AddressesRequests
        describe 'Addresses' do
            let(:json) { JSON.parse(response.body) }

            address_attributes = FactoryGirl.attributes_for :address
            place_attributes   = FactoryGirl.attributes_for :place

            describe 'getting address' do
                before do
                    @place = FactoryGirl.create(:place)
                end

                context 'GET api/v1/places/:id/address' do
                    it 'returns an address of prevoiusly created place' do
                        get "/api/v1/places/#{@place.id}/address"
                        expect(json['number']).to eq(@place.address.number)
                        expect(json['street']).to eq(@place.address.street.name)
                        expect(json['city']).to   eq(@place.address.street.district.city.name)
                    end
                end
            end

            # describe 'POST api/v1/places/:id/address' do
            #     context 'with valid attributes' do
            #         it 'creates a new place' do
            #             expect { post '/api/v1/places', place: place_attributes }.to change(Place, :count).by(1)
            #         end
            #     end
            #
            #     context 'with invalid attributes' do
            #         it 'expects missing name error' do
            #             expect { post '/api/v1/places', place: {description: 'Fajne miejsce'} }
            #                 .not_to change(Place, :count)
            #             expect(json['error']).not_to eq(nil)
            #         end
            #
            #         it 'expects missing description error' do
            #             expect { post '/api/v1/places', place: {name: 'U Szwagra'}}
            #                 .not_to change(Place, :count)
            #             expect(json['error']).not_to eq(nil)
            #         end
            #
            #         it 'expects invalid email format error' do
            #             expect {
            #                 post '/api/v1/places', place: {name: 'U Szwagra', description: 'Fajne miejsce',
            #                                                email: 'invalidemail'}
            #             }.not_to change(Place, :count)
            #
            #             expect(json['error']).not_to eq(nil)
            #         end
            #     end
            # end

            describe 'PATCH api/v1/places/:id/address' do
                before do
                    @place = FactoryGirl.create(:place)
                end

                context 'with valid attributes' do
                    it 'updates an address' do
                        new_address = { number: '1', postcode: '60-000' }
                        patch "/api/v1/places/#{@place.id}/address", new_address

                        expect(json['number']).to   eq(new_address[:number])
                        expect(json['postcode']).to eq(new_address[:postcode])
                        expect(Address.where(place_id: @place.id).first.number).to eq(new_address[:number])
                    end
                end

                context 'with invalid attributes' do
                    it 'returns empty number error' do
                        expect {
                            patch "/api/v1/places/#{@place.id}/address", { number: '' }
                        }.not_to change(Address, :count)

                        expect(json['error']).not_to eq(nil)
                    end
                end

                # it 'unhides a place' do
                #     put "/api/v1/places/#{@place.id}", { hidden: false }
                #
                #     expect(json['hidden']).to eq(false)
                #     expect(Place.find(@place.id).hidden).to eq(false)
                # end
            end

            # describe 'DELETE api/v1/places/:id' do
            #     before do
            #         @place = Place.create! place_attributes
            #     end
            #
            #     it 'hides a place' do
            #         delete "/api/v1/places/#{@place.id}"
            #
            #         expect(json['hidden']).to eq(true)
            #         expect(Place.find(@place.id).hidden).to eq(true)
            #     end
            # end
        end
    end
end
