Fabricator(:user) do
  username { Faker::Internet.user_name }
  name { Faker::Name.name }
  password { Faker::Internet.password }
end
