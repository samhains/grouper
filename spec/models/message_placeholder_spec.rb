require 'rails_helper'

describe MessagePlaceholder do
  it { should have_many(:message_users) }
end
