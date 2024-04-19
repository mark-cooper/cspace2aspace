# cspace2aspace

An experimental ArchivesSpace plugin that adds CollectionSpace functionality.

## Setup

Pre-reqs:

- [nvm](https://github.com/nvm-sh/nvm)
- [rbenv](https://github.com/rbenv/rbenv)

```bash
make install
```

Download the ArchivesSpace source code to a sibling directory and follow the
instructions for [running ArchivesSpace from source](https://archivesspace.github.io/tech-docs/development/dev.html)
to setup a local ArchivesSpace development environment.

_You should be comfortable running ArchivesSpace from source before proceeding._

After confirming you can run ArchivesSpace locally enable the plugin:

```bash
ln -s $PWD $PWD/../archivesspace/plugins/cspace2aspace
touch ../archivesspace/common/config/config.rb
echo "AppConfig[:plugins] << \"cspace2aspace\"" >> ../archivesspace/common/config/config.rb
```

Start the ArchiveSpace backend. The abridged form of doing this is:

```bash
# from the ArchivesSpace source directory, start MySQL and Solr
docker compose -f docker-compose-dev.yml up --detach
# Run the database migrations
./build/run db:migrate
# Run the ArchivesSpace backend only
supervisord -c supervisord/backend.conf
```

If everything is setup correctly the logs should contain:

```txt
[java] I, [2024-04-17T21:46:43.405034 #233223]  INFO -- : Thread-2000: The cspace2aspace plugin is enabled.
```

## Testing Api requests with asclient (optional)

The `asclient` script is install as part of `make install`. Create the file
`~/.asclientrc` with content:

```json
{
  "base_uri": "http://localhost:4567",
  "base_repo": "",
  "username": "admin",
  "password": "admin",
  "page_size": 50,
  "throttle": 0,
  "timeout": 60,
  "verify_ssl": false
}
```

Run commands:

```bash
# --rid (repository id)
asclient exec post --rid 2 collection_objects --payload '{"object_number": "123", "title": "ArchivesSpace"}'
asclient exec get --rid 2 collection_objects --params '{"query": {"page": 1}}' | jq .
asclient exec post --rid 2 collection_objects/1 --payload '{"lock_version": 0, "object_number": "456", "title": "CollectionSpace"}'
asclient exec get --rid 2 collection_objects/1 | jq .
```
