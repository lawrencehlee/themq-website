require_relative 'asset_storage_adapter'

# Handles issues asset storage, mostly by delegating to AssetStorageAdapter
module IssueStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/%s/general/%s"

  def self.upload_photo(volume_no, issue_no, name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
