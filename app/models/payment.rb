class Payment < ApplicationRecord
	validates :method, presence: true
	validates :card_name, presence: true
	validates :card_number, presence: true
	validates :card_CVC, length: {is: 3}
	validates :card_expiry_month, length: {is: 2}, numericality: true
	validates :card_expiry_year, length: {is: 2}, numericality: true
	:amount
	:street_address
	:city
	:state
	:zip_code
  # :responseMessage, :amountReceived, :cardNumberMask,
  # :cardType, :cardTypeCode, :responseCode, :transactionID, :xref

  # # # # # # # Checks for attributes # # # # # # #

  def ifFlex
  	if method == "flex"
  		if card_number.length != 7
  			errors.add(:cardNumber, 'unique ID must be 7 digits')
  		end
  	end
  end

  def ifCard
  	if method == "card"
  		if card_number.length != 16
  			errors.add(:cardNumber, 'card number must be 16 digits')
  		end
  	end
  end
  
end
