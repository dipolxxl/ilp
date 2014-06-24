class TxnSerializer < ActiveModel::Serializer
  attributes :id, :amount, :created_at
end
