Fabricator(:message) do
  text { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph }
  user
end
