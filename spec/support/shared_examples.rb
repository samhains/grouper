shared_examples "requires sign in" do
  it "directs to the login page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end
end

