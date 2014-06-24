class TxnsController < ApplicationController
  def index
    txns = Txn.for_user(params[:user_id])
    render json: txns
  end

  def create
    resp = TxnManager.new(txn_params).save
    head(resp)
  end

  private

  def txn_params
    params.require(:txn).permit(:amount).merge(user_id: params[:user_id])
  end
end
