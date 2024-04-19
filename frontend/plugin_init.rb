routes = File.join(File.dirname(__FILE__), "routes.rb")
ArchivesSpace::Application.extend_aspace_routes(routes)

class SearchResultData
  def self.COLLECTION_OBJECT_FACETS
    []
  end
end
