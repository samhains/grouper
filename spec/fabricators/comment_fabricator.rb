Fabricator(:comment) do
  body { Faker::Lorem.paragraph } 
  post
end
