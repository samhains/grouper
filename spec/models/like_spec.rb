require 'rails_helper'

describe Like do
  it { should belong_to(:user) }
  it { should belong_to(:likeable) }
end
