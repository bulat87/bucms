class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  before_action :set_comment, only: [:destroy]
  load_and_authorize_resource only: [:destroy]
  skip_load_resource only: [:create]

	def create
    @post = Post.find_by_slug!(params[:post_id])
    comment = @post.comments.build(comment_params)
    comment.user = current_user
 
    if comment.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = @comment.post
    @comment.delete
    redirect_to post_path(@post)
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
