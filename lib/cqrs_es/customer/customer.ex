defmodule CqrsEs.Customer do
  @derive Jason.Encoder
  defstruct [:id, :name]

  # This should receive current customer state
  # It should fetch from memory in a GenServer or something
  # If it doesnt have in memory but an id is provided, it should try to fetch from database
  def receive(%{id: customer_id}) when not is_nil(customer_id) do
    %__MODULE__{id: customer_id}
  end

  def receive(_), do: %__MODULE__{}
end
