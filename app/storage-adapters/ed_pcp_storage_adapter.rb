require_relative 'asset_storage_adapter'

# Handles ed_pcps asset storage, mostly by delegating to AssetStorageAdapter
module EdPcpStorageAdapter

  IMAGE_SUBDIRECTORY_STRUCTURE  = "images/%s/ed_pcps/%s"

  def self.upload_ed_pcp_text(volume_no, issue_no, name, file)
    ArticleStorageAdapter.upload_article(volume_no, issue_no, name, file)
  end

  def self.upload_ed_pcp_image(volume_no, issue_no, name, file)
    path = IMAGE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
