module API
    module V1
        module Cities_API
            class Cities < Grape::API
                include API::V1::Defaults

                resource :cities do
                    desc 'Return list of cities'
                    get jbuilder: 'cities/index' do
                        @cities = City.all
                    end
                end
            end
        end
    end
end

