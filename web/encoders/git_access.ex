defimpl Poison.Encoder, for: Stalker.GitAccess do
  def encode(_, _) do
    Poison.encode!(%{a: 1})
  end
end
