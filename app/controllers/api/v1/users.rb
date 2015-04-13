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

        desc 'Create a user'
        params do
          requires :user, type: Hash, desc: "user attributes" do
            requires :email, type: String, allow_blank: false, regexp: /.+@.+/, documentation: { example: 'example@hubeert.com' }
            requires :password, type: String, allow_blank: false
          end
        end
        post do
          User.create! params[:user].to_h
        end


        desc 'Update a user'
        params do
          requires :email, type: String, allow_blank: false, regexp: /.+@.+/, documentation: { example: 'example@hubeert.com' }
          optional :password, type: String, allow_blank: false
          optional :firstname, type: String
          optional :lastname, type: String
          optional :city, type: String
          optional :date_of_birth, type: Date
        end
        patch ':id' do
          user = User.find(params[:id])
          user.update(params.to_h)
          user.save
          user
        end

        desc "Hide a user"
        delete ':id' do
          user = User.find(params[:id])
          user.update(hidden: true)
          user
        end

        desc "Unhide a user"
        put ':id' do
          user = User.find(params[:id])
          user.update(hidden: false)
          user
        end
      end
    end
  end
end
