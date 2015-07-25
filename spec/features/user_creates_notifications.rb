require 'rails_helper'
feature 'User creates notifications' do
  scenario 'User creates post, comments and likes a users material' do
    sam = Fabricate(:user)
    alice = Fabricate(:user)
    discussion1 = Fabricate(:discussion, creator: alice)
    post1 = Fabricate(:post, discussion: discussion1, user: alice)
    sign_in sam
    click_link(discussion1.name)
    click_link('join thread')
    within("//form[@action='/posts']") do
      fill_in "Body", :with => 'Hey Guys'
    end
    fill_in "Title", :with => 'New Post'
    click_button('post')
j
    expect(page).to have_content "New Post"
    expect(page).to have_content "Hey Guys"


    #within("//form[@id='comment_body']") do
      #fill_in "Body", :with => 'New Comment'
    #end

    visit('/logout')
    sign_in alice

    expect(page).to have_content "notifications (1)"
    click_link('notifications')

    expect(page).to have_link sam.name
    expect(page).to have_content "Hey Guys"
    expect(page).to have_content discussion1.name

  end
end
