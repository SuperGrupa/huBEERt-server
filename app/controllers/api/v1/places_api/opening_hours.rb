module API
    module V1
        module Places_API
            class OpeningHours < Grape::API
                include API::V1::Defaults

                resource :places do
                    desc 'Return opening hours of a given place'
                    get ':id/opening_hours', jbuilder: 'places/opening_hours/show' do
                        @opening_hours = Place.find(params[:id]).opening_hours
                    end

                    desc 'Create opening hours'
                    params do
                        requires :opening_hours, type: Array, desc: 'opening hours attributes' do
                            requires :from, type: String, allow_blank: false
                            requires :to, type: String, allow_blank: false
                            requires :days, type: Array do
                                requires :id, type: Integer
                            end
                        end
                    end
                    post ':id/opening_hours' do
                        params[:opening_hours].each do |opening_hour|
                            week_day_ids = opening_hour[:days].map do |day|
                                day[:id]
                            end
                            
                            Place.find(params[:id]).opening_hours.create!(from: opening_hour[:from],
                                to: opening_hour[:to], week_day_ids: week_day_ids)
                        end
                    end

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
