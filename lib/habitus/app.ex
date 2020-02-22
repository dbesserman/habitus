defmodule Habitus.App do
  use Commanded.Application,
    otp_app: :habitus,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Habitus.EventStore
    ]

  router Habitus.Router
end
