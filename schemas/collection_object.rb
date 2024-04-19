{
  schema: {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/repositories/:repo_id/collection_objects",
    "properties" => {
      "uri" => {"type" => "string"},
      "object_number" => {"type" => "string", "minLength" => 1, "maxLength" => 256, "ifmissing" => "error"},
      "title" => {"type" => "string", "minLength" => 1, "maxLength" => 16384, "ifmissing" => "error"},
      "publish" => {"type" => "boolean"},
      "suppressed" => {"type" => "boolean", "readonly" => "true"}
    }
  }
}
