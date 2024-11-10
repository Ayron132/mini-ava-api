class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_post

  def index
    @comments = Comment.includes(:user).where(post_id: params[:post_id])
    render json: @comments.as_json(include: { user: { only: [:id, :name] } })
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_api_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
