class Image < ActiveRecord::Base
	# Relationships
	belongs_to :page

	# Uploaders
  mount_uploader :image, ImageUploader

	# Validations
	validates :title, presence: true
	validates :desc, presence: true
	validates :day, presence: true
	validates :credit, presence: true
end
