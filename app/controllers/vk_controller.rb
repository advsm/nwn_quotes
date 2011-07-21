class VkController < ApplicationController
	def comment
		require 'digest/md5'
		date = params[:date].gsub " ", "+"
		hashfrom = "nBVq9YMWhSmB3vgk2y1N#{date}#{params[:num]}#{params[:last_comment]}"
  		sign = Digest::MD5.hexdigest hashfrom
		if sign != params[:sign]
			#  #{hashfrom} => #{sign} vs #{params[:sign]}
			return render :json => {message: "Hacking attempted?"}
		end
		
		id = params[:id][/_(.+)/, 1]
		@quote = Quote.where(ident: id).first
		@quote.comments_count = params[:num]
		@quote.save
		return render :json => [message: "OK"].to_json
	end
end
