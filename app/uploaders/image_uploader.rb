# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  ##
  # Directory to upload files.
  #
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end
  
  ##
  # Version sizes
  #
  version :thumb do
    process :resize_to_fill => [50, 0]
  end

  version :small do
    process :resize_to_fill => [100, 0]
  end
  
  version :medium do
    process :resize_to_fill => [250, 0]
  end
  
  version :large do
    process :resize_to_fill => [500, 0]
  end
  
  version :xlarge do
    process :resize_to_fill => [900, 0]
  end
  
  # Only allow images
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
