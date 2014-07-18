class Qrcode
	include Mongoid::Document
	include Mongoid::Timestamps
	field :image, type: String
end
