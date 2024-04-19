Sequel.migration do
  up do
    create_table(:cspace_collection_object) do
      primary_key :id

      Integer :lock_version, default: 0, null: false
      Integer :json_schema_version, null: false
      Integer :repo_id, null: false
      Integer :publish
      Integer :suppressed, default: 0, null: false

      String :object_number, null: false
      String :title, null: true

      apply_mtime_columns
    end
  end

  down do
    # Not implemented.
  end
end
