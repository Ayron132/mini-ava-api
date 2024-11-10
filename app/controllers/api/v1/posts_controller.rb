class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_classroom
  before_action :set_post, only: %i[show update destroy]
  before_action :authorize_teacher!, only: %i[create update destroy]
  before_action :authorize_teacher_or_member!, only: [:show]

  def index
    @posts = @classroom.posts
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = @classroom.posts.new(post_params)
    @post.user = current_api_user

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

    def set_classroom
      @classroom = Classroom.find(params[:classroom_id])
    end

    def set_post
      @post = @classroom.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :post_type, fields_attributes: [:field_type, :label, :options])
    end

    def authorize_teacher!
      render json: { error: 'Unauthorized' }, status: :unauthorized unless current_api_user.teacher?
    end

    def authorize_teacher_or_member!
      if current_api_user.teacher? || ClassroomUser.exists?(user: current_api_user, classroom: @classroom)
        return true
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
end
