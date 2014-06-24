FactoryGirl.define do
  factory :txn, class: Txn do
    amount 1
    user
  end
end
