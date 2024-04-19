class CollectionObjectsController < ApplicationController
  set_access_control "view_repository" => [:index, :show],
    "update_collection_object_record" => [:new, :edit, :create, :update],
    "transfer_archival_record" => [:transfer],
    "suppress_archival_record" => [:suppress, :unsuppress],
    "delete_archival_record" => [:delete],
    "manage_repository" => [:defaults, :update_defaults]

  def index
    respond_to do |format|
      format.html {
        @search_data = Search.for_type(session[:repo_id], "collection_object", params_for_backend_search.merge({"facet[]" => SearchResultData.COLLECTION_OBJECT_FACETS}))
      }
      format.csv {
        search_params = params_for_backend_search.merge({"facet[]" => SearchResultData.COLLECTION_OBJECT_FACETS})
        search_params["type[]"] = "collection_object"
        uri = "/repositories/#{session[:repo_id]}/search"
        csv_response(uri, Search.build_filters(search_params), "#{I18n.t("collection_object._plural").downcase}.")
      }
    end
  end

  def show
    @collection_object = JSONModel(:collection_object).find(params[:id], find_opts)

    flash.now[:info] = I18n.t("collection_object._frontend.messages.suppressed_info") if @collection_object.suppressed
  end

  def edit
  end

  def delete
  end

  def defaults
  end

  def transfer
  end
end
