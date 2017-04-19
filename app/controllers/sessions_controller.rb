class SessionsController < ApplicationController

	layout :choose_layout

	def choose_layout
		if request.path_info.include?('/login')
			'userauth'
		else
			'application'
		end
	end


  def new
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      redirect_to '/timeline'
    else
    end

  end

  def create
  	fava_user = FavaUser.find_by(email: params[:session][:email].downcase)
  	if fava_user && fava_user.authenticate(params[:session][:password])
      if fava_user.activated?
    		# Log in and redirect
    		log_in fava_user
        session[:fava_user_id] = fava_user.id
    		redirect_to '/timeline'
      else
        redirect_to confirm_path
      end
  	else
  		# Create error message
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
