module API
  module V1
    class Base < Grape::API
      mount API::V1::Hello
      #mount API::V1::Wings
    end
  end
end