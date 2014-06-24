class TxnManager
  attr_accessor :user, :txn

  def initialize(params)
    @user = User.find(params[:user_id])
    @txn = Txn.new(params)
  end

  def save
    Txn.transaction do
      txn.save!
      user.update(balance: user.txns.sum(:amount))
    end

    :created
  rescue => e
    :unprocessable_entity
  end
end
