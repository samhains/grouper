require 'rails_helper'

describe Friendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }
  it { should validate_presence_of(:friend) }
end
