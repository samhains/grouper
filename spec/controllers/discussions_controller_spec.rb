require 'rails_helper'

describe DiscussionsController do

  let(:user) { Fabricate(:user) }
  let(:discussion) { Fabricate(:discussion) }
  before { set_current_user user}

  describe 'GET #index' do
    it "sets @discussions variable " do
      discussion2 = Fabricate(:discussion)
      get :index
      expect(assigns(:discussions)).to include(discussion, discussion2)
    end
  end

  describe 'GET #my_discussions' do
    it "sets @my_discussions variable" do
      user.discussions << discussion
      get :my_discussions
      expect(assigns(:discussions)).to include(discussion)
    end
  end

  describe 'GET #new' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @discussion instance variable" do
      get :new
      expect(assigns(:discussion)).to be_instance_of(Discussion)
    end
  end

  describe 'PUT #join' do
    
    it_behaves_like "requires sign in" do
      let(:action) { put :join, thread_id: discussion.id }
    end

    it "associates a user with a discussion" do
      put :join, thread_id: discussion.id 
      expect(discussion.reload.users).to include(user)
    end

    it "redirects user to the discussion path" do
      put :join, thread_id: discussion.id 
      expect(response).to redirect_to(thread_path(discussion))
    end
  end

  describe 'POST #create' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @discussion instance variable" do
      post :create, discussion: Fabricate.attributes_for(:discussion)
      expect(assigns(:discussion)).to be_instance_of(Discussion)
    end

    context "valid input " do
      before { post :create, discussion: Fabricate.attributes_for(:discussion) }

      it "saves discussion to database" do
        expect(Discussion.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects user to the discussion page" do
        expect(response).to redirect_to thread_path(Discussion.first)
      end
    end

    context "invalid input " do
      before { post :create, discussion: { description: 'hey' } }

      it "does not save discussion to database" do
        expect(Discussion.count).to eq(0) 
      end

      it "sets flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders discussion/new form" do
        expect(response).to render_template 'discussions/new'
      end
    end
  end

  describe "GET #show" do

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: discussion.id  }
    end

    it "sets @posts to posts of the discussion" do
      post1 = Fabricate(:post, discussion: discussion)
      post2 = Fabricate(:post, discussion: discussion)

      get :show, id: discussion.id
      expect(assigns(:posts)).to include(post1, post2)
    end

    it "sets @posts in reverse chronological order" do
      post1 = Fabricate(:post, discussion: discussion, created_at: 2.weeks.ago)
      post2 = Fabricate(:post, discussion: discussion, created_at: 1.weeks.ago)
      post3 = Fabricate(:post, discussion: discussion, created_at: 3.weeks.ago)
      get :show, id: discussion.id
      expect(assigns(:posts)).to eq([post2, post1, post3])
    end

    it "sets @post" do
      get :show, id: discussion.id
      expect(assigns(:post)).to be_instance_of(Post)
    end
  end

  describe "delete #leave" do
    before do 
      user.discussions << discussion
      user.save
      delete :leave, thread_id: discussion.id 
    end

    it "removes the current users association with discussion" do
      expect(user.reload.discussions).to_not include(discussion)
    end

    it "redirects user to the root path" do
      expect(response).to redirect_to root_path
    end
  end

end
