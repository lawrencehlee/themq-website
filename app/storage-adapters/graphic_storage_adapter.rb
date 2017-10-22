require_relative 'asset_storage_adapter'

# Handles graphics asset storage, mostly by delegating to AssetStorageAdapter
module GraphicStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/%s/graphics/%s"

  def self.upload_graphic(volume_no, issue_no, name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
