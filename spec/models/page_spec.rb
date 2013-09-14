require 'spec_helper'

describe Page do
  before { @page = Page.new(title: "Lorem ipsum dolor sit amet.", url: "http://example.com/", is_copyright: false) }

  subject { @page }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:is_copyright) }
  it { should be_valid }

  describe "when title is not present" do
		before { @page.title = '' }
		it { should_not be_valid }
  end

  describe "when url is not present" do
		before { @page.url = '' }
		it { should_not be_valid }
  end

  describe "when url is already present" do
		before do
			page_with_same_url = @page.dup
			page_with_same_url.save
		end

		it { should_not be_valid }
  end

  describe "when url is an invalid url" do
		before { @page.url = 'invalid url' }
		it { should_not be_valid }
  end

  describe "when url is a valid url" do
		before { @page.url = 'http://example.com/' }
		it { should be_valid }
  end

  describe "when is_copyright is not present" do
		before { @page.is_copyright = '' }
		it { should_not be_valid }
  end

  describe "when is_copyright is true" do
		before { @page.is_copyright = true }
		it { should be_valid }
  end

  describe "when is_copyright is false" do
		before { @page.is_copyright = false }
		it { should be_valid }
  end
end
