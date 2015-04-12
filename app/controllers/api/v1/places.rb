module API
    module V1
        class Places < Grape::API
            include API::V1::Defaults

            resource :places do
                desc 'Return list of places'
                get jbuilder: 'places/index' do
                    @places = Place.all
                end

                desc 'Return one place'
                get ':id', jbuilder: 'places/show' do
                    @place = Place.find(params[:id])
                end

                desc 'Create place'
                params do
                    requires :place, type: Hash, desc: 'place attributes' do
                        requires :name, type: String, allow_blank: false
                        requires :description, type: String, allow_blank: false
                        optional :phone, type: Integer
                        optional :email, type: String, regexp: Place::EMAIL_FORMAT
                    end
                end
                post do
                    Place.create params[:place].to_h
                end

                desc 'Update place'
                params do
                    optional :name, type: String, allow_blank: false
                    optional :description, type: String, allow_blank: false
                    optional :phone, type: Integer
                    optional :email, type: String, regexp: Place::EMAIL_FORMAT
                end
                patch ':id' do
                    place = Place.find(params[:id])
                    place.update(params.to_h)
                    place
                end

                desc 'Hide a place'
                delete ':id' do
                    place = Place.find(params[:id])
                    place.update(hidden: true)
                    place
                end

                desc 'Unhide a place'
                put ':id' do
                    place = Place.find(params[:id])
                    place.update(hidden: false)
                    place
                end

            end
        end
    end
end
