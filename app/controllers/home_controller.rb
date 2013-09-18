class HomeController < ApplicationController
	def index
		@images = Image.paginate(page: params[:page]).order("RANDOM()")
	end
end
