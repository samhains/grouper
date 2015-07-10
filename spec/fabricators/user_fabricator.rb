Fabricator(:user) do
  username { Faker::Lorem.word }
  name { Faker::Name.name }
  password { Faker::Internet.password }
end
