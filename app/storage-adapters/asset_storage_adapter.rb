require 'google/cloud/storage'

# Adapts asset storage to the storage provider of choice, which currently
# is Google Cloud Storage
module AssetStorageAdapter

  # Project id and keyfile path read in from environment variables:
  # GOOGLE_CLOUD_PROJECT, GOOGLE_CLOUD_KEYFILE
  @storage = Google::Cloud::Storage.new
  @bucket = @storage.bucket Settings.assets.bucket

  def self.upload(file, path)
    @bucket.create_file file, path
  end

end
