# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

class Seed
    def self.run
        prepare_week_days
        prepare_cities
        places
    end

    private

        def self.prepare_week_days
            week_days = %w[Poniedziałek Wtorek Środa Czwartek Piątek Sobota Niedziela]

            week_days.each do |day|
                WeekDay.create!(name: day)
            end
        end

        def self.prepare_cities
            # Miasta
            5.times do
                city = City.create!(name: Faker::Address.city)

                # Dzielnice
                (Random.rand(3) + 4).times do
                    district = District.create!(name: Faker::Address.street_name, city_id: city.id)

                    # Ulice
                    (Random.rand(30) + 30).times do
                        Street.create!(name: Faker::Address.street_name, district_id: district.id)
                    end
                end
            end
        end

        def self.opening_hours(pub)
            WeekDay.all.each do |day|
                from = "#{Random.rand(5) + 15}:#{[true, false].sample ? 30 : 00 }"
                to   = if [true, false].sample
                            "#{Random.rand(5)}:#{[true, false].sample ? 30 : 00 }"
                       else
                            nil
                       end

                oh = OpeningHour.create!(place_id: pub.id, from: from, to: to)
                oh.week_days << day
            end
        end

        def self.address(pub)
            number = Random.rand(300)
            postcode = "#{Random.rand(90) + 10}-#{Random.rand(900) + 100}"

            Address.create!(place_id: pub.id, number: number, postcode: postcode,
                            street_id: Street.ids.sample)
        end

        def self.places
            30.times do
                name = Faker::Name.name
                description = Faker::Lorem.paragraph
                phone = Random.rand(300000000) + 500000000
                email = Faker::Internet.email

                pub = Place.create!(name: name, description: description, phone: phone, email: email)
                opening_hours(pub)
                address(pub)
            end
        end
end

Seed::run
