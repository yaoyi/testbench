require 'sinatra'
require 'mongoid'
require 'json'

Mongoid.load!("config/mongoid.yml")
class Qrcode
    include Mongoid::Document
    field :image, type: String
    field :expired_at, type: DateTime
end
get '/:id' do
  @qrcode = Qrcode.find params[:id]
	@qrcode.to_json
end

get '/qrcodes.json' do
	@qrcodes = Qrcode.all
	@qrcodes.to_json
end
