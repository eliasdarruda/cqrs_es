defimpl CqrsEs.MutatorProtocol, for: CqrsEs.Customer.Events.CustomerNameChanged do
  alias CqrsEs.Customer
  alias CqrsEs.Customer.Events.CustomerNameChanged

  def apply(%CustomerNameChanged{name: name}, customer) do
    uppercase_name = String.upcase(name)

    %Customer{customer | name: uppercase_name}
  end
end
