class Api::V1::ResponsesController < ApplicationController
  before_action :authenticate_api_user!

  def index
    @post = Post.find(params[:post_id])
    @responses = @post.responses.includes(:user)
  
    render json: @responses.map { |response| response_with_user_name(response) }, status: :ok
  end  

  def create
    @post = Post.find(params[:post_id])
    @response = @post.responses.new(response_params)
    @response.user = current_api_user 
  
    if @response.save
      render json: response_with_user_name(@response), status: :created
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  private

  def response_params
    permitted = params.require(:response).permit!
    { data: permitted }
  end

  def response_with_user_name(response)
    response_data = response.as_json.merge(user_name: response.user.name)

    response_data.merge(response.data || {})
  end
end
