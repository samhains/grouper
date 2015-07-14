Fabricator(:post) do
  title { Faker::Lorem.word }
  body { Faker::Lorem.paragraph }
  group
  user
end
