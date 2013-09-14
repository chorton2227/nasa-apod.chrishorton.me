class Image < ActiveRecord::Base
	# Relationships
	belongs_to :page

	# Validations
	validates :title, presence: true
	validates :image, presence: true
	validates :desc, presence: true
	validates :day, presence: true
	validates :credit, presence: true
end
