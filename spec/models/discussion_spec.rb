require 'rails_helper'

describe Discussion do
  it { should have_many(:users).through(:discussion_users) } 
  it { should have_many(:posts) }
  it { should validate_presence_of(:name) }
end
