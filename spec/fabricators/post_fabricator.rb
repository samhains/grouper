Fabricator(:post) do
  title { Faker::Lorem.word }
  body { Faker::Lorem.paragraph }
  discussion
  user
end
