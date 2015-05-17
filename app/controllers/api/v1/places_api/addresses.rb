module API
    module V1
        module Places_API
            class Addresses < Grape::API
                include API::V1::Defaults

                resource :places do
                    desc 'Return address of a given place'
                    get ':id/address', jbuilder: 'places/address/show' do
                        @address = Address.includes(street: {district: :city}).where(place_id: params[:id]).first
                    end

                    desc 'Create address'
                    params do
                        requires :address, type: Hash, desc: 'address attributes' do
                            requires :street, type: Hash do
                                requires :id, type: Integer
                                requires :number, type: Integer
                            end
                            requires :postcode, type: String, allow_blank: false
                        end
                    end
                    post ':id/address' do
                        address = {
                            postcode: params[:address][:postcode],
                            number: params[:address][:street][:number],
                            street_id: params[:address][:street][:id]
                        }
                        Place.find(params[:id]).create_address(address)
                    end

                    # desc 'Update address'
                    # params do
                    #     optional :number, type: String, allow_blank: false
                    #     optional :postcode, type: String, allow_blank: false
                    # end
                    # patch ':id/address' do
                    #     address = Address.where(place_id: params[:id]).first
                    #     address.update(params.to_h)
                    #     address
                    # end
                    #
                    # CZY USUWAMY ADRESY CZY TEŻ TYLKO UKRYWAMY? (NUMER, KOD POCZTOWY)
                    #
                    # desc 'Hide a place'
                    # delete ':id' do
                    #     place = Place.find(params[:id])
                    #     place.update(hidden: true)
                    #     place
                    # end
                    #
                    # desc 'Unhide a place'
                    # put ':id' do
                    #     place = Place.find(params[:id])
                    #     place.update(hidden: false)
                    #     place
                    # end

                end
            end
        end
    end
end
