require_relative 'asset_storage_adapter'

# Handles skyboxes asset storage, mostly by delegating to AssetStorageAdapter
module SkyboxStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/%s/skyboxes/%s"

  def self.upload_skybox(volume_no, issue_no, name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
