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
				get jbuilder: 'places/index' do
					# wywal znaki " z nazwy miasta
					params[:city] = params[:city].tr("\"", "")

					@places = Place.includes(address: [street: {district: :city}])
								   .find_all { |place| place.address.street.district.city.name == params[:city] }
								   .shuffle
				end
			end
		end
	end
end
