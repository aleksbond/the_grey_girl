class BlogsController < ApplicationController

  def index
    @blogs = Blog.published.order(:id).page params[:page]
  end
  
  def archive
    @blogs = Blog.published.order(:id)
  end

  def current
    @blog = Blog.published.last
    redirect_to @blog
  end
  
  def show
    @blog = Blog.published.find(params[:id])
  end

end
