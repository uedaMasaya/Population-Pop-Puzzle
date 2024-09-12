class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [200, 200]
    process :convert_to_circle
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  private

  def convert_to_circle
    manipulate! do |img|
      img.format "png"
      img.combine_options do |c|
        c.alpha 'transparent'
        c.background 'none'
        c.gravity 'center'
        c.extent '200x200'
        c.draw 'circle 100,100 100,1'
      end
      img
    end
  end
end