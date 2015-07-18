require 'spec_helper'

describe Post do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should belong_to(:discussion) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:discussion) }
end
