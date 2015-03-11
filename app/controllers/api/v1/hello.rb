module API
  module V1
    class Hello < Grape::API
      include API::V1::Defaults

      get "hello" do
        "Grape, hello world"
      end


    end
  end
end