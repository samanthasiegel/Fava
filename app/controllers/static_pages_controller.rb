class StaticPagesController < ApplicationController
  def home
  end

  def submit_pin
  	fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
    	fava_user.update(pin: request_params[:pin])
    	fava_user.save
    	redirect_to timeline_path
    else
    	redirect_to root_path
    end

  end

  def getting_started
  	fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
    	@fava_user = fava_user
    else
    	redirect_to root_path
    end
  end


  def request_params
      params.require(:fava_user).permit(:pin)

  end

end
