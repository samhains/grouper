Fabricator(:discussion) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
end
