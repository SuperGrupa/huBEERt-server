module API
    module V1
        module OpeningHours_API
            class WeekDays < Grape::API
                include API::V1::Defaults

                resource :opening_hours do
                    desc 'Return list of week days'
                    get 'week_days', jbuilder: 'opening_hours/week_days' do
                        @week_days = WeekDay.all.select(:id, :name)
                    end
                end
            end
        end
    end
end
