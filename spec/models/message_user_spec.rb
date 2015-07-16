require 'rails_helper'

describe MessageUser do
  it { should belong_to(:user) }
  it { should belong_to(:message) }
end
