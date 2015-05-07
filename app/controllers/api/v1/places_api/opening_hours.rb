module API
    module V1
        module Places_API
            class OpeningHours < Grape::API
                include API::V1::Defaults

                resource :places do
                    # desc 'Return list of places'
                    # get jbuilder: 'places/index' do
                    #     @places = Place.includes(address: [street: {district: :city}])
                    # end

                    desc 'Return opening hours of a given place'
                    get ':id/opening_hours', jbuilder: 'places/opening_hours/show' do
                        @opening_hours = Place.find(params[:id]).opening_hours
                    end

                    # desc 'Create address'
                    # params do
                    #     requires :address, type: Hash, desc: 'address attributes' do
                    #         requires :number, type: String, allow_blank: false
                    #         requires :postcode, type: String, allow_blank: false
                    #         requires :place_id, type: Integer
                    #         requires :street_id, type: Integer
                    #     end
                    # end
                    # post ':id/address' do
                    #     Address.create params[:address].to_h
                    # end
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
