require 'rails_helper'

feature 'User Interacts With Threads' do
  scenario 'User creates thread and posts on it' do
    sam = Fabricate(:user)
    discussion1 = Fabricate(:discussion)
    discussion2 = Fabricate(:discussion)

    sign_in sam

    expect(page).to have_button(discussion1.name)
    expect(page).to have_button(discussion2.name)
    expect(page).to have_link("Threads")
    click_link("Threads")
    expect(page).to have_button("Create Thread")
    click_link("Create Thread")

    fill_in('Name', with: 'Contemporary Music')
    fill_in('Description', with: 'discuss music')
    expect(page).to have_button("Create Thread")
    click_button("Create Thread")

    expect(page).to have_content("New Discussion Created!")
    expect(page).to have_button("Join Thread")
    click_link("Join Thread")
    fill_in('Title', with: "Welcome to my group!")
    fill_in('Body', with: "first post!")
    click_button('Post')
    expect(page).to have_content("Welcome to my group!")
    expect(page).to have_content("first post!")
  end

  scenario "User joins threads and looks at them in newsfeed" do
    sam = Fabricate(:user)
    discussion3 = Fabricate(:discussion)
    post1 = Fabricate(:post)
    post2 = Fabricate(:post)
    discussion3.posts << [post1, post2]
    sign_in sam

    click_link("#{discussion3.name}")
    expect(page).to have_content(discussion3.description)
    click_link("Join Thread")

    click_link("GARP")
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.body)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post2.body)
  end
end
