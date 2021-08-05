import Config

config :cqrs_es, event_stores: [CqrsEs.EventStore]

config :cqrs_es, CqrsEs.EventStore,
  serializer: EventStore.JsonSerializer,
  username: "postgres",
  password: "password",
  database: "eventstore",
  hostname: "database"

import_config "#{config_env()}.exs"
