class AccountActivationsController < ApplicationController

	def edit
		fava_user = FavaUser.find_by(email: params[:email])
		if fava_user && !fava_user.activated? && fava_user.authenticated?(:activation, params[:id])
			fava_user.update_attribute(:activated, true)
			fava_user.update_attribute(:activated_at, Time.zone.now)
			log_in fava_user
			redirect_to '/timeline'
		elsif fava_user && fava_user.activated
			log_in fava_user
			redirect_to '/timeline'
		else
			redirect_to root_url
		end
	end
end
