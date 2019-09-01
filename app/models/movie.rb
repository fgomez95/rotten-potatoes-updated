class Movie < ApplicationRecord
	def self.order_asc 
		# db query Movie.order('title asc')
		# bellow applied to the object
		Movie.all.sort_by { |movie| movie.title }
	end
end
