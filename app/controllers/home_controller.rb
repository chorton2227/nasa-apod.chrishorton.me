class HomeController < ApplicationController
	def index
		@images = Image.all(:order => "RANDOM()")
	end
end
