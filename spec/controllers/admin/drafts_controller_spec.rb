require 'rails_helper'

RSpec.describe Admin::DraftsController, :type => :controller do
  include Devise::TestHelpers
  include ControllerHelpers
  
  before do
    login_admin
    @blog = Blog.create!
    @blog.draft_creation
  end
  
  describe "GET index" do
    it "assigns all drafts as @drafts" do
      get :index, {}
      expect(assigns(:drafts)).to eq([@blog.draft])
    end
  end

  describe "GET show" do
    it "assigns the requested blog as @blog" do
      get :show, {:id => @blog.draft.to_param}
      expect(assigns(:draft)).to eq(@blog.draft)
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "publishes draft" do
        put :update, {:id => @blog.draft.to_param, :commit_publication => true }
        @blog.reload
        expect(@blog.published_at).not_to be_nil
      end
    end

    describe "with invalid params" do
      it "re-renders the 'update' template" do
        put :update, {:id => @blog.draft.to_param, :commit_publication => false }
        expect(response).to render_template("update")
      end
    end
  end
  
  describe "DELETE destroy" do
    describe "to revert draft" do
      it "publishes draft" do
        put :update, {:id => @blog.draft.to_param, :commit_reversion => true }
        @blog.reload
        expect(@blog.trashed_at).to be_nil
      end
    end

    describe "with invalid params" do
      it "re-renders the 'update' template" do
        put :update, {:id => @blog.draft.to_param, :commit_reversion => false }
        expect(response).to render_template("update")
      end
    end
  end
end
