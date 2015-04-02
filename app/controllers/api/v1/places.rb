module API
    module V1
        class Places < Grape::API
            include API::V1::Defaults

            resource :places do
                desc 'Return list of places'
                get jbuilder: 'places/index' do
                    @places = Place.all
                end

                desc 'Return one place'
                get ':id', jbuilder: 'places/show' do
                    @place = Place.find(params[:id])
                end

                desc 'Create place'
                params do
                    requires :place, type: Hash, desc: 'place attributes' do
                        requires :email, type: String, allow_blank: false, regexp: /.+@.+/, documentation: { example: 'example@hubeert.com' }
                        requires :password, type: String, allow_blank: false
                    end
                end
                post do
                    Place.create! params[:place].to_h
                end

                desc 'Update place'
                params do
                    requires :user, type: Hash, desc: "user attributes" do
                        optional :email, type: String, allow_blank: false, regexp: /.+@.+/, documentation: { example: 'example@hubeert.com' }
                        optional :password, type: String, allow_blank: false
                        optional :firstname, type: String
                        optional :lastname, type: String
                        optional :city, type: String
                        optional :date_of_birth, type: Date
                    end
                end

                patch ':id' do
                    user = User.find(params[:id])
                    user.update(params[:user].to_h)
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
