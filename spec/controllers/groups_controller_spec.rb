require 'rails_helper'

describe GroupsController do

  describe 'GET #new' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @group instance variable" do
      set_current_user
      get :new
      expect(assigns(:group)).to be_instance_of(Group)
    end
  end

  describe 'POST #create' do

    before { set_current_user }

    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @group instance variable" do
      post :create, group: Fabricate.attributes_for(:group)
      expect(assigns(:group)).to be_instance_of(Group)
    end

    context "valid input " do
      before { post :create, group: Fabricate.attributes_for(:group) }

      it "saves group to database" do
        expect(Group.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects user to the group page" do
        expect(response).to redirect_to group_path(Group.first)
      end
    end

    context "invalid input " do
      before { post :create, group: { description: 'hey' } }

      it "does not save group to database" do
        expect(Group.count).to eq(0) 
      end

      it "sets flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders group/new form" do
        expect(response).to render_template 'groups/new'
      end
    end
  end
end
