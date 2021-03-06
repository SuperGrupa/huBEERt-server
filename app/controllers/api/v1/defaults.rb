module API
    module V1
        module Defaults
            # if you're using Grape outside of Rails, you'll have to use Module#included hook
            extend ActiveSupport::Concern

            included do
                # common Grape settings
                version 'v1'
                format :json
                formatter :json, Grape::Formatter::Jbuilder

                # global handler for simple not found case
                rescue_from ActiveRecord::RecordNotFound do |e|
                    error_response(message: e.message, status: 404)
                end

                helpers do
                  def current_user
                    token = AuthToken.where(token: headers["Authorization"]).first
                    if token
                        @current_user = token.user
                    else
                        @current_user = nil
                    end
                  end

                  def authenticate!
                    error!('401 Unauthorized', 401) unless current_user
                  end
                end

                # global exception handler, used for error notifications
=begin

                rescue_from :all do |e|
                    if Rails.env.development?
                        raise e
                    else
                        Raven.capture_exception(e)
                        error_response(message: "Internal server error", status: 500)
                    end
                end
=end

=begin
        # HTTP header based authentication
        before do
          error!('Unauthorized', 401) unless headers['Authorization'] == "some token"
        end
=end
            end
        end
    end
end
