class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  skip_load_resource only: [:create]

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 10, order: "created_at DESC")
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 10, order: "created_at DESC")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render action: 'edit'
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_slug!(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :tag_list)
    end
end
