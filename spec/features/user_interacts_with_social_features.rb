require 'rails_helper'

feature 'User Interacts With Social Features' do
  scenario 'User friends some users and views friends page' do
    sam = Fabricate(:user)
    discussion1 = Fabricate(:discussion)
    discussion2 = Fabricate(:discussion)
    alice = Fabricate(:user)
    bob = Fabricate(:bob)
    post1 = Fabricate(:post, discussion: discussion1, user: alice)
    post2 = Fabricate(:post, discussion: discussion2, user: bob)
    puts "hello"

    sign_in sam
    save_and_open_page
  end

end
