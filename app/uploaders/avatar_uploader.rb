class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]
  storage :file

  def store_dir
    "upload/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url *args
    ActionController::Base.helpers.asset_path("imagedefault/" +
      [version_name, "avatar.png"].compact.join("_"))
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
