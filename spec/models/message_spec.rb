require 'rails_helper'

describe Message do
  it { should belong_to(:author) }
  it { should have_many(:message_users) }
  it { should have_many(:users).through(:message_users) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author) }
end
