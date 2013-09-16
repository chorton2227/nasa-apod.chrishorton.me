Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

fog_dir = Rails.env == 'production' ? 'static.nasa-apod.chrishorton.me' : 'static.nasa-apod.chrishorton.me'
asset_host = Rails.env == 'production' ? '//static.nasa-apod.chrishorton.me.s3.amazonaws.com' : '//static.nasa-apod.chrishorton.me.s3.amazonaws.com'

CarrierWave.configure do |config|
  config.fog_credentials   = { provider: 'AWS' }  
  config.storage           = :fog
  config.cache_dir         = Rails.root.join('tmp', 'upload')
  config.fog_directory     = fog_dir
  config.fog_public        = true
  config.asset_host        = asset_host
end
