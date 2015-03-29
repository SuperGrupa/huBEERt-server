module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc "Return list of users"
        get jbuilder: 'users/index' do
          @users = User.all
        end

        desc "Return one user"
        get ':id', jbuilder: 'users/show' do
          @user = User.find(params[:id])
        end





        params do
          requires :user, type: Hash, desc: "user attributes" do
            requires :email, type: String, allow_blank: false, regexp: /.+@.+/, documentation: { example: 'example@hubeert.com' }
            requires :password, type: String, allow_blank: false
          end
        end

        desc 'Create a user'
        post do
          User.create! params[:user].to_h
        end

      end
    end
  end
end