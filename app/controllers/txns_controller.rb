class TxnsController < ApplicationController
  def index
    txns = Txn.for_user(params[:user_id])
    render json: txns
  end
end
