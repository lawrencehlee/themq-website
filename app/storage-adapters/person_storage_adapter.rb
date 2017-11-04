require_relative 'asset_storage_adapter'

# Handles person  asset storage, mostly by delegating to AssetStorageAdapter
module PersonStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/editors/%s"

  def self.upload_editor_photo(name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % [name]
    AssetStorageAdapter.upload(file, path)
  end
end
