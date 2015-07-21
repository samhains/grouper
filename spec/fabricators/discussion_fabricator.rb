Fabricator(:discussion) do
  name { Faker::Internet.domain_word }
  description { Faker::Lorem.sentence }
  last_updated { 1.day.ago }
  creator { Fabricate(:user) }
end
