require 'date'
require 'nokogiri'
require 'open-uri'

@base_url = "http://apod.nasa.gov/apod/"
@archive_page = @base_url + "archivepix.html"
@archive_doc = Nokogiri::HTML(open(@archive_page))

##
# Crawl NASA Astronomy Picture of the Day archive for images.
#
task :crawl_nasa_apod => :environment do
	Page.destroy_all
	Image.destroy_all
	get_astronomy_pages().each do |page|
		if Page.where(url: page).length == 0
			create_astronomy_page_and_image(page)
		end
	end
end

##
# Parse the archive for astronomy picture of the day pages.
#
def get_astronomy_pages()
	return @archive_doc.css('body b a').map { |page| @base_url + page["href"] }
end

##
# Create the astronomy page.
# If page/picture is not copyrighted, create astronomy image.
#
def create_astronomy_page_and_image(page)
	# get astronomy html
	page_doc = Nokogiri::HTML(open(page))

	# get page attributes
	image_credit = get_image_credit(page_doc)
	is_copyright = is_image_copyrighted(image_credit)
	page_title = get_page_title(page_doc)

	puts page_title

	# create astronomy page
	astronomy_page = Page.new(title: page_title, url: page, is_copyright: is_copyright)
	if astronomy_page.save
		puts "Added astronomy page #{page_title}"
	else
		puts "Failed to add astronomy page #{page_title}"
		return
	end

	# if copyrighted, do not create image
	if is_copyright
		puts "Astronomy page/picture is copyrighted, skip adding image"
		return
	end

	# get the astronomy image and check if exists
	image_url = get_image_url(page_doc)
	if image_url.nil?
		puts "Image not found, remove astronomy page #{page_title}"
		astronomy_page.destroy
		return
	end

	# get image attributes
	image_title = get_image_title(page_doc)
	image_desc = get_image_desc(page_doc)
	image_day = get_image_day(page_doc)

	# create astronomy image
	astronomy_image = Image.new(title: image_title, desc: image_desc, day: DateTime.now, credit: image_credit)
	astronomy_image.remote_image_url = image_url
	if astronomy_image.save
		puts "Added astronomy image #{image_title}"
	else
		puts "Failed to add astronomy image #{image_title}"
		astronomy_page.destroy
		return
	end
end

##
# Get the title of a page.
#
def get_page_title(page_doc)
	return page_doc.css('title').text.strip
end

##
# Check the credit of image to see if it is copyrighted.
#
def is_image_copyrighted(image_credit)
	is_copyright = false
	if image_credit.downcase.include? 'copyright'
		is_copyright = true
	end

	return is_copyright
end

##
# Get the title of an image.
#
def get_image_title(page_doc)
	page_title = get_page_title(page_doc)
	index = page_title.index('-') + 1
	return page_title[index, page_title.length].strip
end

##
# Get the description of an image.
#
def get_image_desc(page_doc)
	return page_doc.css('//body/p')[-2].inner_html
end

##
# Get the day of the astronomy image.
#
def get_image_day(page_doc)
	return DateTime.parse(page_doc.css('body center:nth-child(1) p')[1].text.strip)
end

##
# Get the source of the astronomy picture.
#
def get_image_url(page_doc)
	image_url = page_doc.css('body center:nth-child(1) a img')

	if image_url.nil? or image_url.length == 0
		return nil
	end

	return @base_url + image_url[0]["src"]
end

##
# Get the credit of the image.
#
def get_image_credit(page_doc)
	image_credit = page_doc.css('body center:nth-child(2)')
	image_credit.search('.//b')[0].remove
	image_credit.search('.//br').remove
	image_credit.search('center').remove
	return image_credit.inner_html.strip!
end
