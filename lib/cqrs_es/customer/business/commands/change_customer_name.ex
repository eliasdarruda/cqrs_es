defimpl CqrsEs.CommandProtocol, for: CqrsEs.Customer.Events.ChangeCustomerName do
  alias CqrsEs.Customer
  alias CqrsEs.Customer.Events.{ChangeCustomerName, CustomerNameChanged}

  def apply(%ChangeCustomerName{id: id, name: name}, %Customer{id: id}) do
    {:ok, %CustomerNameChanged{id: id, name: name}}
  end
end
