module API
    module V1
        module Places_API
            class Categories < Grape::API
                include API::V1::Defaults

                resource :places do
                    desc 'Return categories of a given place'
                    get ':id/categories', jbuilder: 'categories/index' do
                        @categories = Place.find(params[:id]).categories
                    end
                end
                
                resource :categories do
                    desc 'Get list of all available categories'
                    get '/', jbuilder: 'categories/index' do
                        @categories = Category.all
                    end
                end
            end
        end
    end
end
