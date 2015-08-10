class BlogsController < ApplicationController

  def index
    @blogs = Blog.published.order(id: :desc).page(params[:page]).per(5)
    @blogs.reject! { |blog| blog.trashed? }
  end
  
  def archive
    @blogs = Blog.published.order(id: :desc)
    @blogs.reject! { |blog| blog.trashed? }
  end

  def current
    @blog = Blog.published.last
    redirect_to @blog
  end
  
  def show
    @blog = Blog.published.find(params[:id])
  end

end
