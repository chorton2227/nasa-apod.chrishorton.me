require 'spec_helper'

describe Image do
  before { @image = Image.new(title: "Lorem ipsum dolor sit amet.", image: "/dir/image.jpg",
  	desc: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Delectus, voluptatem.",
  	day: DateTime.now, credit: "Lorem ipsum dolor sit amet, consectetur adipisicing.") }

  subject { @image }

  it { should respond_to(:title) }
  it { should respond_to(:image) }
  it { should respond_to(:desc) }
  it { should respond_to(:day) }
  it { should respond_to(:credit) }
  it { should be_valid }

  describe "when title is not present" do
		before { @image.title = '' }
		it { should_not be_valid }
  end

  describe "when image is not present" do
		before { @image.image = '' }
		it { should_not be_valid }
  end

  describe "when desc is not present" do
		before { @image.desc = '' }
		it { should_not be_valid }
  end

  describe "when day is not present" do
		before { @image.day = '' }
		it { should_not be_valid }
  end

  describe "when day is not a date" do
		before { @image.day = 'string' }
		it { should_not be_valid }
  end

  describe "when credit is not present" do
		before { @image.credit = '' }
		it { should_not be_valid }
  end
end
