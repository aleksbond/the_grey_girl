class BlogsController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show, :index, :current, :archive]

  def index
    @blogs = Blog.order(:id).page params[:page]
  end
  
  def archive
    @blogs = Blog.order(:id)
  end

  def current
    @blog = Blog.last
    redirect_to @blog
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
    @blog = Blog.find(params[:id])

    if @blog.update(blog_params)
      redirect_to @blog
    else
      render 'edit'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def destroy
    @blog = Article.find(params[:id])
    @blog.destroy

    redirect_to blogs_path
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :text)
    end
end
