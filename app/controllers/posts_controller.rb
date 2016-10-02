class PostsController < ApplicationController

  def show
    @post = Post.find_by_id(params[:id])
  end

  def index
    @posts = Post.one_day.junior
  end


  private

  def post_params
    params.require(:post).permit(:id)
  end
end
