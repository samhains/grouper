Fabricator(:friendship) do
  friend { Fabricate(:user) }
  user
end
