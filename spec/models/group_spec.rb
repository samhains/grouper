require 'rails_helper'

describe Group do
  it { should have_many(:users).through(:group_users) } 
  it { should have_many(:posts) }
  it { should validate_presence_of(:name) }
end
