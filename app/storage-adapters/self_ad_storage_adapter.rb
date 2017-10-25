require_relative 'asset_storage_adapter'

# Handles self ads asset storage, mostly by delegating to AssetStorageAdapter
module SelfAdStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/%s/self_ads/%s"

  def self.upload_self_ad(volume_no, issue_no, name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
