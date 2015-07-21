def set_current_user(user=nil)
  user = user || Fabricate(:user)
  session[:user_id] = user.id 
end

def sign_in(user=nil)
  user = user || Fabricate(:user)
  visit login_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  click_button "Sign In"
  expect(page).to have_content "Welcome, #{ user.name }"
end


