require 'rails_helper'

module Api
    module WeekDaysRequests
        describe 'WeekDays' do
            before do
                week_days = ['Poniedziałek', 'Wtorek', 'Środa', 'Czwartek', 'Piątek', 'Sobota', 'Niedziela']
                week_days.each do |day|
                    WeekDay.create(name: day)
                end
            end
        
            let(:json) { JSON.parse(response.body) }

            describe 'getting week days list' do
                context 'GET api/v1/opening_hours/week_days' do
                    it 'returns an array of week days' do
                        get '/api/v1/opening_hours/week_days'
                        
                        expect(json.length).to be == 7
                        expect(json.first['id']).not_to be(nil)
                        expect(json.first['name']).to eq('Poniedziałek')
                    end
                end
            end
        end
    end
end
