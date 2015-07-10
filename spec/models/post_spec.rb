require 'spec_helper'

describe Post do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should belong_to(:group) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:group) }
  it { should validate_presence_of(:title) }
end
