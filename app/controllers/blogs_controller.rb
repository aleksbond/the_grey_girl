class BlogsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  
  def index
    @blogs = Blog.all
  end
  
  def new
  end
  
  def show
    @blog = Blog.find(params[:id])
  end
  
  def create
    @blog = Blog.new(blog_params)

    @blog.save
    redirect_to @blog
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    def blog_params
      params.require(:blog).permit(:title, :text)
    end
end
