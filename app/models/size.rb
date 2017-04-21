class Size < ApplicationRecord


	def format_price()
	    string_tip = price.to_s
	    if string_tip.index('.') == -1
	      string_tip += '.00'
	    elsif string_tip.index('.') == string_tip.size - 2
	      string_tip += '0'
	    end
	    return string_tip
  	end

end
