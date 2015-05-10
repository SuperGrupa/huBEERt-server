module API
    module V1
        module Cities_API
            class Districts < Grape::API
                include API::V1::Defaults

                resource :cities do
                    desc 'Return list of districts in a given city'
                    get ':id/districts', jbuilder: 'cities/districts/index' do
                        @districts = District.where(city_id: params[:id])
                    end
                end
            end
        end
    end
end
