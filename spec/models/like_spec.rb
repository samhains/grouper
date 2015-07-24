require 'rails_helper'

describe Like do
  it { should belong_to(:user) }
  it { should belong_to(:likeable) }
  it { should have_many(:notifications) }
end
