module API
    module V1
        module Search_API
            class Search < Grape::API
                include API::V1::Defaults

                desc 'Return list of places matching given search text'
                params do
                    requires :q, type: String, allow_blank: false
                    requires :city, type: String, allow_blank: false
                end
                get jbuilder: 'search/index' do
                    # wywal znaki " z nazwy miasta i z zapytania
                    params[:city] = params[:city].tr("\"", "")
                    params[:q] = params[:q].tr("\"", "")

                    @places = Place.includes(address: [street: {district: :city}])
                                   .find_all { |place| place.address.street.district.city.name == params[:city] }

                    @ratings = @places.map do |place|
                        { place: place, searchRating: place.rate(params[:q].split(" ")) }
                    end
                    @ratings.sort! { |r1, r2| r2[:searchRating] <=> r1[:searchRating] }
                    @ratings.delete_if { |rating| rating[:searchRating] == 0 }
                end
            end
        end
    end
end
