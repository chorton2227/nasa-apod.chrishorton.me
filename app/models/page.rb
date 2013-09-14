class Page < ActiveRecord::Base
	# Relationships
	has_many :images, dependent: :destroy

	# Validations
	validates :title, presence: true
	validates :url, presence: true, uniqueness: true, url: true
	validates :is_copyright, inclusion: [true, false]
end
