defmodule CqrsEs.Customer.Router do
  use GenServer

  require Logger

  alias CqrsEs.Customer.Events.{AddCustomer, ChangeCustomerName}

  @impl true
  def init(state) do
    Logger.debug("Customer.Router initialized")

    {:ok, state}
  end

  @impl true
  def handle_cast({:add_customer, name}, state) do
    send_event(AddCustomer, %AddCustomer{name: name})

    {:noreply, state}
  end

  @impl true
  def handle_cast({:change_name, id, new_name}, state) do
    send_event(ChangeCustomerName, %ChangeCustomerName{id: id, name: new_name})

    {:noreply, state}
  end

  ## CLIENT
  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: via())
  end

  def add_customer(name) do
    GenServer.cast(via(), {:add_customer, name})
  end

  def change_name(id, new_name) do
    GenServer.cast(via(), {:change_name, id, new_name})
  end

  defp via() do
    {:via, Registry, {CqrsEs.Registry, __MODULE__}}
  end

  defp send_event(event_type, event, metadata \\ %{}) do
    events = [
      %EventStore.EventData{
        event_type: "Elixir." <> inspect(event_type),
        data: event,
        metadata: metadata
      }
    ]

    CqrsEs.EventStore.append_to_stream(CqrsEs.customer_events_topic(), :any_version, events)
  end
end
