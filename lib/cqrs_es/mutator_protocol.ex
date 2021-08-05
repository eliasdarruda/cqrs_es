defprotocol CqrsEs.MutatorProtocol do
  @type target :: term()

  @spec apply(term(), target) :: target
  def apply(event, target)
end
