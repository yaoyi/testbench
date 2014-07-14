require 'sinatra'
require 'mongoid'
require 'json'

# initialize log
require 'logger'
Dir.mkdir('log') unless File.exist?('log')
class ::Logger; alias_method :write, :<<; end
case ENV["RACK_ENV"]
when "production"
  logger = ::Logger.new("log/production.log")
  logger.level = ::Logger::WARN
when "development"
  logger = ::Logger.new(STDOUT)
  logger.level = ::Logger::DEBUG
else
  logger = ::Logger.new("/dev/null")
end

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

get '/qrcodes.json' do
	@qrcodes = Qrcode.all
	@qrcodes.to_json
end
