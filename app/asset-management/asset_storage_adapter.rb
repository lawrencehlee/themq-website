require 'google/cloud/storage'

module AssetStorageAdapter
  # Project id and keyfile path read in from environment variables:
  # GOOGLE_CLOUD_PROJECT, GOOGLE_CLOUD_KEYFILE
  @@storage = Google::Cloud::Storage.new
  @@bucket = @@storage.bucket Settings.assets.bucket

  def self.upload(path, file)
    @@bucket.create_file file, path
  end
end
