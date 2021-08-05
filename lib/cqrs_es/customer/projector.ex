defmodule CqrsEs.Customer.Projector do
  @moduledoc """
  This module will handle successfully projected customer facts
  Here is supposed to write to database
  """

  use GenServer

  require Logger

  defmodule State do
    defstruct []
  end

  def init(_state) do
    Phoenix.PubSub.subscribe(CqrsEs.PubSub, CqrsEs.customer_events_topic())

    Logger.debug("Customer projector initialized")
    {:ok, []}
  end

  ## CLIENT
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end
end
