Fabricator(:message_user) do
  user
  message
  is_read false
end
