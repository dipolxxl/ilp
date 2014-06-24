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

  User.find_or_create_by!(
    name: "User #{i}",
    email: "user#{i}@test.cc",
    # balance: i * Random.new.rand(10)
  )
end

# Create 5 transactions for every user
User.all.each do |user|
  next if user.txns.size >= 5

  (5 - user.txns.size).times do
    user.txns.create(
      amount: [1, -1].sample
    )
  end
end
