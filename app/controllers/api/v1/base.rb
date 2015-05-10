require 'grape-swagger'

module API
    module V1
        class Base < Grape::API
            mount API::V1::Users
            
            mount API::V1::Places_API::Places
            mount API::V1::Places_API::Addresses
            mount API::V1::Places_API::OpeningHours
            
            mount API::V1::Cities_API::Cities
            mount API::V1::Cities_API::Districts
            
            add_swagger_documentation api_version: 'api/v1'
        end
    end
end
