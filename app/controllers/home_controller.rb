class HomeController < ApplicationController
	def index
		@images = Image.all(:order => "RANDOM()").take(12)
	end
end
