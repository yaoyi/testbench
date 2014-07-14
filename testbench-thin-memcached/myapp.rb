require 'sinatra'
require 'mongoid'
require 'json'
require 'dalli'
set :cache, Dalli::Client.new

Mongoid.load!("config/mongoid.yml")
class Qrcode
    include Mongoid::Document
    field :image, type: String
    field :expired_at, type: DateTime
end
get '/:id' do
	if settings.cache.get(params[:id]).nil?
	  @qrcode = Qrcode.find params[:id]
	  settings.cache.set(params[:id], @qrcode)
	end    
	@qrcode.to_json
end

get '/qrcodes.json' do
	@qrcodes = Qrcode.all
	@qrcodes.to_json
end
