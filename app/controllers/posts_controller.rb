class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post saved successfully."
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to posts_path, notice: "Post saved successfully."
    else
      render :edit
    end
  end

  protected 
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
