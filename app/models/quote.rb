class Quote 
	include Mongoid::Document
	include Mongoid::Timestamps
	field :content, type: String
	field :rating, type: Integer
	field :approved_at, type: Time
	belongs_to :user
end

