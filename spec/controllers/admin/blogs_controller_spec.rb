require 'rails_helper'

RSpec.describe Admin::BlogsController, :type => :controller do
  include Devise::TestHelpers
  include ControllerHelpers
  
  before do
    login_admin
  end
  
  let(:valid_attributes) { {title: "Blog title", text: "Blog text" } }
  
  describe "GET new" do
    it "assigns a new blog as @blog" do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "assigns the requested blog as @blog" do
      blog = Blog.create! valid_attributes
      get :edit, {:id => blog.to_param}
      expect(assigns(:blog)).to eq(blog)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Blog" do
        expect {
          post :create, {:blog => valid_attributes}
        }.to change(Blog, :count).by(1)
      end

      it "assigns a newly created blog as @blog" do
        post :create, {:blog => valid_attributes}
        expect(assigns(:blog)).to be_a(Blog)
        expect(assigns(:blog)).to be_persisted
      end

      it "redirects to the created blog" do
        post :create, {:blog => valid_attributes}
        expect(response).to redirect_to(admin_blogs_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved blog as @blog" do
        # Trigger the behavior that occurs when invalid params are submitted
        Blog.any_instance.stub(:save).and_return(false)
        post :create, {:blog => { title: "Blog title" }}
        expect(assigns(:blog)).to be_a_new(Blog)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Blog.any_instance.stub(:save).and_return(false)
        post :create, {:blog => { title: "Blog title" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested blog" do
        blog = Blog.create! valid_attributes
        # Assuming there are no other blogs in the database, this
        # specifies that the Blog created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Blog).to receive(:draft_update).and_return(true)
        put :update, {:id => blog.to_param, :blog => { "these" => "params" }}
      end

      it "assigns the requested blog as @blog" do
        blog = Blog.create! valid_attributes
        put :update, {:id => blog.to_param, :blog => valid_attributes}
        expect(assigns(:blog)).to eq(blog)
      end

      it "redirects to the blog" do
        blog = Blog.create! valid_attributes
        put :update, {:id => blog.to_param, :blog => valid_attributes}
        expect(response).to redirect_to(admin_blogs_path)
      end
    end

    describe "with invalid params" do
      it "assigns the blog as @blog" do
        blog = Blog.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Blog.any_instance.stub(:save).and_return(false)
        put :update, {:id => blog.to_param, :blog => { title: "Blog title" }}
        expect(assigns(:blog)).to eq(blog)
      end

      it "re-renders the 'edit' template" do
        blog = Blog.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Blog.any_instance.stub(:save).and_return(false)
        put :update, {:id => blog.to_param, :blog => { title: "Blog title" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested blog" do
      blog = Blog.create! valid_attributes
      delete :destroy, {:id => blog.to_param}
      blog.reload
      expect(blog.trashed_at).not_to be_nil
    end

    it "redirects to the blogs list" do
      blog = Blog.create! valid_attributes
      delete :destroy, {:id => blog.to_param}
      expect(response).to redirect_to(admin_blogs_path)
    end
  end
end
