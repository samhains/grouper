Fabricator(:notification) do
  notifiable { Fabricate([:post, :comment, :like].sample) }
  user_checked false
  user
end
