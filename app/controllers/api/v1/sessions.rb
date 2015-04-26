module API
  module V1
    class Sessions < Grape::API
      include API::V1::Defaults
      use Rack::JSONP

      # after do
      #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      # end

      resource :auth do

        desc 'Log in a user'
        params do
          requires :email, type: String, allow_blank: false, regexp: /.+@.+/
          requires :password, type: String, allow_blank: false
        end
        post 'login' do
          user = User.find_for_database_authentication(email: params[:email])
          if user && user.valid_password?(params[:password])
            # user.class.module_eval { attr_accessor :token}
            user.ensure_authentication_token
            user
          else
            status 300
          end
        end


        desc 'Log out a user'
        delete 'logout' do
          current_user.authentication_token = nil
          current_user.save!
          status 200
        end
      end
    end
  end
end
