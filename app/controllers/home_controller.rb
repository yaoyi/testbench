class HomeController < ApplicationController
	def index
		@qrcode = Qrcode.find(params[:id])
		render json: @qrcode.to_json
	end
end