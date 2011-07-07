class Quote 
	include Mongoid::Document
	field :content, type: String
	field :rating, type: Integer
	field :approved_at, type: Date
	belongs_to :user
	belongs_to :quote
end

