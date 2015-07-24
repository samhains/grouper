require 'rails_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:notifiable) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:notifiable) }
end
