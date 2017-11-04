require_relative 'asset_storage_adapter'

# Handles articles asset storage, mostly by delegating to AssetStorageAdapter
module ArticleStorageAdapter

  ARTICLE_SUBDIRECTORY_STRUCTURE = "articles/%s/%s"

  def self.upload_article(volume_no, issue_no, name, file)
    path = ARTICLE_SUBDIRECTORY_STRUCTURE % ["#{volume_no}.#{issue_no}", name]
    AssetStorageAdapter.upload(file, path)
  end
end
