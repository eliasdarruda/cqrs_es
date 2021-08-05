defimpl CqrsEs.MutatorProtocol, for: CqrsEs.Customer.Events.CustomerAdded do
  alias CqrsEs.Customer
  alias CqrsEs.Customer.Events.CustomerAdded

  def apply(%CustomerAdded{id: id, name: name}, customer) do
    uppercase_name = String.upcase(name)

    %Customer{customer | id: id, name: uppercase_name}
  end
end
