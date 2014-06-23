FactoryGirl.define do
  factory :user, class: User do
    name    { Faker::Name::first_name }
    email   { Faker::Internet.email }
    balance 0
  end
end
