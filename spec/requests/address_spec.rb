require 'rails_helper'

module Api
    module AddressesRequests
        describe 'Addresses' do
            before do
                @place = FactoryGirl.create(:place)
            end

            let(:json) { JSON.parse(response.body) }

            address_attributes = FactoryGirl.attributes_for :address
            place_attributes   = FactoryGirl.attributes_for :place

            describe 'getting address' do
                context 'GET api/v1/places/:id/address' do
                    it 'returns an address of prevoiusly created place' do
                        get "/api/v1/places/#{@place.id}/address"
                        expect(json['number']).to eq(@place.address.number)
                        expect(json['street']).to eq(@place.address.street.name)
                        expect(json['city']).to   eq(@place.address.street.district.city.name)
                    end
                end
            end

            describe 'POST api/v1/places/:id/address' do
                context 'with valid attributes' do
                    it 'creates a new address for place' do
                        expect {
                            post "/api/v1/places/#{@place.id}/address",
                            address: address_attributes
                        }.to change(Address, :count).by(1)
                    end
                end
                
                context 'with invalid attributes' do
                    it 'missing postcode' do
                        expect {
                            post "/api/v1/places/#{@place.id}/address", address: { number: "1" }
                        }.not_to change(Address, :count)
                        expect(json['error']).not_to eq(nil)
                    end
                    it 'missing info' do
                        expect {
                            post "/api/v1/places/#{@place.id}/address", address: { postcode: '60-150' }
                        }.not_to change(Address, :count)
                        expect(json['error']).not_to eq(nil)
                    end
                    it 'expects invalid street format error' do
                        expect {
                            post "/api/v1/places/#{@place.id}/address",
                                address: { postcode: '60-150', street: { number: '1', test: '1' } }
                        }.not_to change(Address, :count)
                        expect(json['error']).not_to eq(nil)
                    end
                end
            end
        end
    end
end
