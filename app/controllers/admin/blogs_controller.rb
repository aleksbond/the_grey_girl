class Admin::BlogsController < Admin::BaseController
  before_filter :find_blog,  :only => [:show, :edit, :update, :destroy]
  before_filter :reify_blog, :only => [:show, :edit]
  
  def index
    @blogs = Blog.live.order(id: :desc)
    @blogs.each { |blog| blog.draft.reify if blog.draft? }
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
      redirect_to admin_blogs_path
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
    @blog.draft_destroy
    flash[:success] = 'The blog was moved to the trash.'
    redirect_to admin_blogs_path
  end

  private
    def find_blog
      @blog = Blog.live.find(params[:id])
    end

    # If the widget has a draft, load that version of it
    def reify_blog
      @blog = @blog.draft.reify if @blog.draft?
    end
    
    def blog_params
      params.require(:blog).permit(:title, :text)
    end
end
