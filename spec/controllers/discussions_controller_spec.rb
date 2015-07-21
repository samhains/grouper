require 'rails_helper'

describe DiscussionsController do

  let(:user) { Fabricate(:user) }
  let(:discussion) { Fabricate(:discussion) }
  before { set_current_user user}

  describe 'GET #index' do
    it "sets @discussions for all " do
      discussion2 = Fabricate(:discussion)
      get :index, type: 'all'
      expect(assigns(:discussions)).to include(discussion, discussion2)
    end

    it "sets @discussions variable for my" do
      user.discussions << discussion
      get :index, type: :following
      expect(assigns(:discussions)).to include(discussion)
    end

    it "sets @discussions variable for following" do
      discussion.creator = user
      discussion.save
      user.discussions << discussion
      get :index, type: :my
      expect(assigns(:discussions)).to include(discussion)
    end
  end

  describe 'GET #my' do
  end

  describe 'GET #following' do
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

      it "sets the discussion user to the creator of discussion" do
        expect(Discussion.first.creator).to eq(user)
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


end
