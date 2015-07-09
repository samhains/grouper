require 'rails_helper'

describe User do
  it { should have_many(:groups).through(:group_users) } 
  it { should have_many(:posts) }
  it { should have_many(:comments) }
end

