module API
    module V1
        module Cities_API
            class Streets < Grape::API
                include API::V1::Defaults

                resource :districts do
                    desc 'Return list of streets in a given district'
                    get ':id/streets', jbuilder: 'cities/streets/index' do
                        @streets = Street.where(district_id: params[:id])
                    end
                end
            end
        end
    end
end
