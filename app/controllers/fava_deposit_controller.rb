class FavaDepositController < ApplicationController
layout 'internal'
  def index
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @paymentMethods = ["Flex", "Debit/Credit"]
          @requests = Request.all.order('updated_at DESC')
      else
        redirect_to root_path
      end
  end

  def flex
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @payment = Payment.new
          @payment.method = "flex"
      else
        redirect_to root_path
      end
  end

  def card
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @payment = Payment.new
      else
        redirect_to root_path
      end
  end

  def create
    Payment.create(person_params)
  end

  private

  def payment_params
      params.require(:payment).permit(:card_name, :card_number, :card_CVC, :card_expiry_month, :card_expiry_year, 
      	:amount, :street_address, :city, :state, :zip_code)
  end
end
