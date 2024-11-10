class Api::V1::ClassroomsController < ApplicationController
  before_action :authenticate_api_user!  
  before_action :set_classroom, only: %i[show update destroy]
  before_action :authorize_teacher!, only: %i[create update destroy]

  def index
    if current_api_user.teacher?
      @classrooms = current_api_user.classrooms
    else
      @classrooms = Classroom.joins(:classroom_users).where(classroom_users: { user_id: current_api_user.id })
    end

    render json: @classrooms.as_json(only: [:id, :title, :description, :code])
  end

  def show
    render json: @classroom
  end

  def create
    puts params.inspect
    @classroom = current_api_user.classrooms.new(classroom_params) 
    @classroom.code = generate_unique_code 

    if @classroom.save
      render json: @classroom, status: :created, location: api_classroom_url(@classroom)
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  def update
    if @classroom.update(classroom_params)
      render json: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @classroom.destroy!
    head :no_content
  end

  def join
    @classroom = Classroom.find_by(code: params[:code])
    if @classroom
      if ClassroomUser.find_by(user: current_api_user, classroom: @classroom).nil?
        ClassroomUser.create!(user: current_api_user, classroom: @classroom)
        render json: { message: 'Joined classroom successfully' }, status: :ok
      else
        render json: { error: 'Already joined this classroom' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Classroom not found' }, status: :not_found
    end
  end

  private

    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    def classroom_params
      params.require(:classroom).permit(:title, :description)
    end

    def authorize_teacher!
      render json: { error: 'Unauthorized' }, status: :unauthorized unless current_api_user.teacher?
    end

    def generate_unique_code
      SecureRandom.hex(4) 
    end
end
