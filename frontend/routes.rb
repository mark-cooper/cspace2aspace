ArchivesSpace::Application.routes.draw do
  scope AppConfig[:frontend_proxy_prefix] do
    resources :collection_objects
    match "collection_objects/defaults" => "collection_objects#defaults", :via => [:get]
    match "collection_objects/:id/delete" => "collection_objects#delete", :via => [:post]
  end
end
