Fabricator(:comment) do
  body { Faker::Lorem.paragraph } 
  user
  post
end
