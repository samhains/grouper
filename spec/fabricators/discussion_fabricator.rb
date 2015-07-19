Fabricator(:discussion) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
  last_updated { 1.day.ago }
  creator { Fabricate(:user) }
end
