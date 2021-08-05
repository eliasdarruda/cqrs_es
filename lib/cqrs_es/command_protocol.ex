defprotocol CqrsEs.CommandProtocol do
  @type target :: term()
  @type origin_event :: term()
  @type fact :: term()

  @spec apply(origin_event, target) :: {:ok, fact} | {:error, term}
  def apply(origin_event, target)
end
