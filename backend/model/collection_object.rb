class CollectionObject < Sequel::Model(:cspace_collection_object)
  include ASModel
  corresponds_to JSONModel(:collection_object)

  include Publishable

  enable_suppression
  set_model_scope :repository
end
