(1..10).each do |i|
  User.create!(login:         Faker::Internet.user_name,
               email:         Faker::Internet.free_email,
               password:      Faker::Internet.password,
               firstname:     Faker::Name.first_name,
               lastname:      Faker::Name.last_name,
               date_of_birth: rand(50.years).ago,
               city:          Faker::Address.city)
end

User.create!(login:         'admin',
             email:         'admin@hubeert.pl',
             password:      'admin',
             firstname:     'Ad',
             lastname:      'Min',
             city:          'Poznan')