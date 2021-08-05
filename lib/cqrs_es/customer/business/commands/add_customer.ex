defimpl CqrsEs.CommandProtocol, for: CqrsEs.Customer.Events.AddCustomer do
  alias CqrsEs.Customer
  alias CqrsEs.Customer.Events.{AddCustomer, CustomerAdded}

  def apply(%AddCustomer{name: name} = _event, %Customer{}) do
    {:ok, %CustomerAdded{id: UUID.uuid4(), name: name}}
  end
end
