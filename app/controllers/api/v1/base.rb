require 'grape-swagger'

module API
    module V1
        class Base < Grape::API
            mount API::V1::Users
            mount API::V1::Places
            add_swagger_documentation api_version: 'api/v1'
        end
    end
end
