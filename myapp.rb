require 'rubygems'
require 'sinatra'
require 'unicorn'
require 'mongoid'
require 'json'

Mongoid.load!("config/mongoid.yml")
class Qrcode
    include Mongoid::Document
    field :image, type: String
    field :expired_at, type: DateTime
end
before do
  content_type :json
end
get '/:id' do
	@qrcode = Qrcode.find params[:id]
	@qrcode.to_json
end
