FactoryGirl.define do
  factory :txn, class: Txn do
    amount 0
    user
  end
end
