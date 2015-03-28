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
      end
    end
  end
end