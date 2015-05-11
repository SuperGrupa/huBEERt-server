module API
  module V1
    class Authentication < Grape::API
      include API::V1::Defaults
      use Rack::JSONP

      # after do
      #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      # end

      resource :auth do

        desc 'Register a user'
        params do
          requires :email, type: String, allow_blank: false, regexp: /.+@.+/, documentation: { example: 'example@hubeert.com' }
          requires :login, type: String, allow_blank: false
          requires :password, type: String, allow_blank: false
          optional :remember, type: Boolean, allow_blank: false
        end
        post 'register', jbuilder: 'authentication/register' do
          @user = User.create params.to_h
          if @user.save
            @token = @user.ensure_authentication_token(params[:remember])
          else
            @user = nil
            @error = "Podane dane są niepoprawne"
          end
        end

        desc 'Log in a user'
        params do
          optional :email, type: String, allow_blank: false
          requires :password, type: String, allow_blank: false
          optional :remember, type: Boolean, allow_blank: false
        end
        post 'login', jbuilder: 'authentication/login' do
          @user = User.find_for_database_authentication(email: params[:email]) || User.find_for_database_authentication(login: params[:email])
          if @user
            if @user.valid_password?(params[:password])
              @token = @user.ensure_authentication_token(params[:remember])
            else
              @user = nil
              @error = "Niepoprawne hasło"
            end
          else
            @error = "Niepoprawny email lub login"
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
