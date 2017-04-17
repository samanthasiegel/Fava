class FavaUser < ApplicationRecord
	attr_accessor :remember_token, :activation_token
	before_save :downcase_email
	before_create :create_activation_digest
	validates :first_name, presence: true
	validates :last_name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@duke.edu+\z/i
	validates :email, presence:true, length:{maximum:255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :phone, presence:true, :numericality => true, length:{is: 10}
	# validates :pin, presence:false,length:{maximum: 4, minimum: 4}
	has_secure_password


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
