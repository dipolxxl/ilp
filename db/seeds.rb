# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create 10 users
10.times do |i|
  i += 1

  User.create(
    name: "User #{i}",
    email: "user#{i}@test.cc",
    balance: i * Random.new.rand(10)
  )
end
