class Admin::BlogsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :find_widget,  :only => [:show, :edit, :update, :destroy]
  before_filter :reify_widget, :only => [:show, :edit]
  
  def index
    @blogs = Blog.live.includes(:draft).order(:id)
    @blogs.map! { |blog| blog.draft.reify if blog.draft? }
  end
  
  def show
  end
  
  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    
    if @blog.draft_creation
      flash[:success] = 'A draft of the new blog was saved successfully.'
      redirect_to admin_widgets_path
    else
      flash[:error] = 'There was an error creating the blog. Please review the errors below and try again.'
      render :new
    end
  end

  def update    
    @blog.attributes = blog_params

    # Instead of calling `update_attributes`, you call `draft_update` to save it as a draft
    if @blog.draft_update
      flash[:success] = 'A draft of the blog update was saved successfully.'
      redirect_to admin_blogs_path
    else
      flash[:error] = 'There was an error updating the blog. Please review the errors below and try again.'
      render :edit
    end
  end

  def edit
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_to blogs_path
    
    @blog.draft_destroy
    flash[:success] = 'The blog was moved to the trash.'
    redirect_to admin_blogs_path
  end

  private
    def find_widget
      @blog = Blog.live.find(params[:id])
    end

    # If the widget has a draft, load that version of it
    def reify_widget
      @blog = @blog.draft.reify if @blog.draft?
    end
    
    def blog_params
      params.require(:blog).permit(:title, :text)
    end
end
