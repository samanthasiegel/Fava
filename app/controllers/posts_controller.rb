class PostsController < ApplicationController
	layout 'internal'
  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
  	@restaurants = Restaurant.all
  end


  def create
    @post = Post.new(post_params)
	respond_to do |format|
	    flash.now[:info] = "Your request has been posted"
	    format.html {redirect_to timeline_path}
	end
  end

  def post_params
      params.require(:post).permit(:FoodItem_id, :Restaurant_id, :notes)
  end


end
