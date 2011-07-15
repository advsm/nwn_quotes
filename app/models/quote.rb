
require 'sequence'

class Quote 
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paranoia
	include Mongoid::Sequence

	# Auto increment for Quotes
	field :ident, type: Integer
	sequence :ident

	field :content, type: String
	field :approved_at, type: DateTime, default: nil
	belongs_to :user
	
	validates_presence_of :content
	validates_length_of :content, minimum: 10, maximum: 2000
	validation_uniqueness_of :ident
end

