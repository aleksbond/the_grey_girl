class HomeController < ApplicationController
  
  def index
    redirect_to current_blogs_path
  end
end
