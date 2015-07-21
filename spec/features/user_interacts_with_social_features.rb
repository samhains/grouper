require 'rails_helper'

feature 'User Interacts With Social Features' do
  scenario 'User friends some users and views friends page' do
    sam = Fabricate(:user)
    discussion1 = Fabricate(:discussion)
    discussion2 = Fabricate(:discussion)
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    post1 = Fabricate(:post, discussion: discussion1, user: alice)
    post2 = Fabricate(:post, discussion: discussion2, user: bob)
    sign_in sam

    add_user_as_friend(alice, discussion1)
    add_user_as_friend(bob, discussion2)

    click_link("Friends")

    expect(page).to have_link(alice.name)
    expect(page).to have_link(bob.name)

  end

end

def add_user_as_friend(user, discussion)
    click_link(discussion.name)
    expect(page).to have_content(discussion.description)
    click_link(user.name)
    click_link("Add Friend")
    expect(page).to have_content("You have added a friend!")
    click_link("GARP")
end
