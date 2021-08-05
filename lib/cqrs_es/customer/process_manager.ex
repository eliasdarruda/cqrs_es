defmodule CqrsEs.Customer.ProcessManager do
  use GenServer

  require Logger

  alias CqrsEs.EventStore
  alias CqrsEs.Customer

  def init(events) do
    Process.flag(:trap_exit, true)
    Logger.debug("Customer.ProcessManager initialized")

    topic = CqrsEs.customer_events_topic()

    {:ok, subscription} = EventStore.subscribe_to_stream(topic, topic, self())

    {:ok, %{events: events, subscription: subscription}}
  end

  def terminate(_state, _reason) do
    Logger.debug("Customer.ProcessManager terminated")
  end

  def handle_info({:subscribed, subscription}, %{subscription: subscription} = state) do
    Logger.debug("Customer.ProcessManager subscribed to #{inspect(subscription)}")

    {:noreply, state}
  end

  def handle_info({:events, events}, state) do
    %{events: existing_events, subscription: subscription} = state

    _events_to_project =
      events
      |> Enum.map(fn %{data: event} ->
        customer_state = Customer.receive(event)
        handle(event, customer_state)
      end)
      |> Enum.reject(fn
        {:error, :invalid} -> true
        _ -> false
      end)

    # send events_to_project to pubsub to notify projector

    :ok = EventStore.ack(subscription, events)

    {:noreply, %{state | events: existing_events ++ events}}
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  defp handle(event, customer_state) do
    case CqrsEs.CommandProtocol.apply(event, customer_state) do
      {:ok, event} ->
        # Should it emit this fact to store or mutate it directly???
        # Like "CustomerAdded" to store and then receive this event to apply afterwards
        mutated_customer = CqrsEs.MutatorProtocol.apply(event, customer_state)

        IO.inspect mutated_customer

        {:ok, mutated_customer}

      {:error, reason} ->
        Logger.error("Error when handling event with reason: #{reason}")

        {:error, reason}
    end
  end
end
