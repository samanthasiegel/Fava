module SessionsHelper

	def log_in(fava_user)
		session[:fava_user_id] = fava_user.id
	end

	def remember(fava_user)
		fava_user.remember
		cookies.permanent.signed[:fava_user_ud] = fava_user.id
		cookies.permanent[:remember_token] = fava_user.remember_token
	end

	def current_fava_user
		if(fava_user_id = session[fava_user.id])
			@current_fava_user ||= FavaUser.find_by(id: fava_user_id)
		elsif (fava_user_id = cookies.signed[:fava_user_id])
			fava_user = FavaUser.find_by(id: fava_user_id)
			if fava_user && fava_user.authenticated?(:remember, cookies[:remember_token])
				log_in fava_user
				@current_fava_user = fava_user
			end
		end
	end

	def logged_in?
		!current_fava_user.nil?
	end

	def log_out
		forget(current_fava_user)
		session.delete(:fava_user_id)
		@current_fava_user = nil
	end
end
