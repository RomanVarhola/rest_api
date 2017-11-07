# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pass = '12345678'
  User.create!(
    email:    'admin@example.com',
    password: pass,
    password_confirmation: pass,
    role: 1,
    first_name: 'admin',
    last_name: 'admin',
    number_phone: '+111111111'
  )

  5.times do |i|
   User.create!(
        first_name:  Faker::Name.first_name,
        last_name:   Faker::Name.last_name,
        password:  pass,
        password_confirmation: pass,
        email:     "#{i}_" + Faker::Internet.safe_email,
        role: 0,
        number_phone: '+111111111'
    )
    puts "create user ##{i}" if i
  end
