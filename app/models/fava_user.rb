class FavaUser < ApplicationRecord
	attr_accessor :remember_token, :activation_token
	before_save :downcase_email
	before_create :create_activation_digest
	validates :first_name, presence: true
	validates :last_name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@duke.edu+\z/i
	VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
	# Validates that email is @duke.edu
	validates :email, presence:true, length:{maximum:255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	# Validates phone number entry
	validates :phone, presence:true, length:{minimum: 10}, format: {with:VALID_PHONE_REGEX}
	has_secure_password

	def format_points()
	    string_tip = fava_points.to_s
	    if string_tip.index('.') == -1
	      string_tip += '.00'
	    elsif string_tip.index('.') == string_tip.size - 2
	      string_tip += '0'
	    elsif string_tip[string_tip.index('.'), string_tip.length].length > 4
		      p "HERE"
		      string_tip = string_tip[0, string_tip.index('.') + 3]
	    end
	    return string_tip
  	end

	def FavaUser.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def FavaUser.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = FavaUser.new_token
		update_attribute(:remember_digest, FavaUser.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated? (attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end


	private
		def downcase_email
			self.email = email.downcase
		end

		def create_activation_digest
			self.activation_token = FavaUser.new_token
			self.activation_digest = FavaUser.digest(activation_token)
		end
		

end
