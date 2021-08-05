defmodule CqrsEs.Application do
  use Application

  def start(_, _) do
    children = [
      {Registry, keys: :unique, name: CqrsEs.Registry},
      CqrsEs.EventStore,
      {Phoenix.PubSub, name: CqrsEs.PubSub},
      {CqrsEs.Customer.Router, []},
      {CqrsEs.Customer.ProcessManager, []}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Dispatcher.Supervisor)
  end
end
