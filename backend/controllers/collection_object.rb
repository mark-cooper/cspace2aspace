class ArchivesSpaceService < Sinatra::Base
  Endpoint.get("/repositories/:repo_id/collection_objects")
    .description("Get a list of CollectionObjects for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:collection_object)]"]) do
    handle_listing(CollectionObject, params)
  end

  Endpoint.get("/repositories/:repo_id/collection_objects/:id")
    .description("Get a CollectionObject by ID")
    .params(["id", :id],
      ["repo_id", :repo_id],
      ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:collection_object)"]) do
    json = CollectionObject.to_jsonmodel(params[:id])
    json_response(resolve_references(json, params[:resolve]))
  end

  Endpoint.post("/repositories/:repo_id/collection_objects")
    .description("Create a CollectionObject")
    .params(["collection_object", JSONModel(:collection_object), "The record to create", body: true],
      ["repo_id", :repo_id])
    .permissions([:update_collection_object_record])
    .returns([200, :created]) do
    handle_create(CollectionObject, params[:collection_object])
  end

  Endpoint.post("/repositories/:repo_id/collection_objects/:id")
    .description("Update a CollectionObject")
    .params(["id", :id],
      ["collection_object", JSONModel(:collection_object), "The updated record", body: true],
      ["repo_id", :repo_id])
    .permissions([:update_collection_object_record])
    .returns([200, :updated]) do
    handle_update(CollectionObject, params[:id], params[:collection_object])
  end
end
