Fabricator(:like) do
  user
  likeable { Fabricate([:post, :comment].sample) }
end
