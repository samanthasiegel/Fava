class PaymentsController < ApplicationController
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
          @payment.method = "card"
      else
        redirect_to root_path
      end
  end

  def create
  	@fava_user = FavaUser.find_by_id(session[:fava_user_id])
  	if payment_params[:card_name] != nil
  		if payment_params[:method] == "flex"
  			@payment = Payment.new(:user_id => @fava_user.id, :method => payment_params[:method], 
  				:card_name => payment_params[:card_name], :card_number => payment_params[:card_number], 
  				:card_expiry_month => payment_params[:card_expiry_month], :card_expiry_year => payment_params[:card_expiry_year], 
  				:card_CVC => payment_params[:card_CVC], :street_address => payment_params[:street_address], 
  				:city => payment_params[:city], :state => payment_params[:state], 
  				:zip_code => payment_params[:zip_code], :amount => payment_params[:amount])
  			  	fava_user_balance = @fava_user.fava_points
  				fava_user_new_balance = fava_user_balance + payment_params[:amount].to_f
				@fava_user.update(fava_points: fava_user_new_balance)
  		elsif payment_params[:method] == "card"
  			@payment = Payment.new(:user_id => @fava_user.id, :method => payment_params[:method], 
  				:card_name => payment_params[:card_name], :card_number => payment_params[:card_number], 
  				:card_expiry_month => payment_params[:card_expiry_month], :card_expiry_year => payment_params[:card_expiry_year], 
  				:card_CVC => payment_params[:card_CVC], :street_address => payment_params[:street_address], 
  				:city => payment_params[:city], :state => payment_params[:state], 
  				:zip_code => payment_params[:zip_code], :amount => payment_params[:amount])
  			  	fava_user_balance = @fava_user.fava_points
  				fava_user_new_balance = fava_user_balance + payment_params[:amount].to_f
				@fava_user.update(fava_points: fava_user_new_balance)
  		end
  	else
  		raise "error"
    end
    respond_to do |format|
        flash.now[:info] = "Your request has been posted"
        flash.keep
        format.html {redirect_to timeline_path}
     end
  end

  private

  def payment_params
      params.require(:payment).permit(:method, :card_name, :card_number, :card_CVC, :card_expiry_month, :card_expiry_year, 
      	:amount, :street_address, :city, :state, :zip_code)
  end
end

