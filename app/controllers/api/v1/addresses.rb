module API
    module V1
        class Addresses < Grape::API
            include API::V1::Defaults

            resource :places do
                # desc 'Return list of places'
                # get jbuilder: 'places/index' do
                #     @places = Place.includes(address: [street: {district: :city}])
                # end

                desc 'Return address of a given place'
                get ':id/address', jbuilder: 'address/show' do
                    @address = Address.includes(street: {district: :city}).where(place_id: params[:id]).first
                end

                desc 'Create address'
                params do
                    requires :address, type: Hash, desc: 'address attributes' do
                        requires :number, type: String, allow_blank: false
                        requires :postcode, type: String, allow_blank: false
                        requires :place_id, type: Integer
                        requires :street_id, type: Integer
                    end
                end
                post ':id/address' do
                    Address.create params[:address].to_h
                end

                # CZY RESTANGULAR BĘDZIE DZIAŁAŁ Z TYM FORMATEM ŻĄDAŃ? :id/address
                #
                # desc 'Update place'
                # params do
                #     optional :name, type: String, allow_blank: false
                #     optional :description, type: String, allow_blank: false
                #     optional :phone, type: Integer
                #     optional :email, type: String, regexp: Place::EMAIL_FORMAT
                # end
                # patch ':id' do
                #     place = Place.find(params[:id])
                #     place.update(params.to_h)
                #     place
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
