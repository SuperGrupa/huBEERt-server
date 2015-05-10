module API
  module V1
    class Authentication < Grape::API
      include API::V1::Defaults
      use Rack::JSONP

      # after do
      #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      # end

      resource :auth do

        desc 'Log in a user'
        params do
          optional :email, type: String, allow_blank: false, regexp: /.+@.+/
          optional :login, type: String, allow_blank: false
          requires :password, type: String, allow_blank: false
          optional :remember, type: Boolean, allow_blank: false
        end
        post 'login', jbuilder: 'authentication/login' do
          @user = User.find_for_database_authentication(email: params[:email])
          if @user && @user.valid_password?(params[:password])
            # @user.class.module_eval { attr_accessor :token}
            @token = @user.ensure_authentication_token(params[:remember])
          else
            status 300
          end
        end


        desc 'Log out a user'
        delete 'logout' do
          token = AuthToken.where(token: headers["Authorization"])
          token.destroy_all
        end
      end
    end
  end
end
