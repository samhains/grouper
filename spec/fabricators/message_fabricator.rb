Fabricator(:message) do
  text { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph }
  author { Fabricate(:user) }
end
