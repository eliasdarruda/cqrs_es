defmodule CqrsEs.Customer.Events do
  defmodule AddCustomer do
    @derive Jason.Encoder
    defstruct [:name]
  end

  defmodule CustomerAdded do
    @derive Jason.Encoder
    defstruct [:id, :name]
  end

  defmodule ChangeCustomerName do
    @derive Jason.Encoder
    defstruct [:id, :name]
  end

  defmodule CustomerNameChanged do
    @derive Jason.Encoder
    defstruct [:id, :name]
  end
end
