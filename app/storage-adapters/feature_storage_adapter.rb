require_relative 'asset_storage_adapter'

# Handles features asset storage, mostly by delegating to AssetStorageAdapter
module FeatureStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/%s/features/%s"

  def self.upload_feature(volume_no, issue_no, name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
