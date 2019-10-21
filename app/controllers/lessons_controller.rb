class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]
  #double check line above

  def show
   if not current_lesson.course.any_enrollment?(current_user)
      return render plain: 'Unauthorized', status: :unauthorized and redirect_to lessons_path(@section)
      #double check line above, do not understand Flash message instead of unauthorized
      # redirect_to lesson_path, alert 'You are not enrolled in this course'
    end
  end

  private

  helper_method :current_lesson
    def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
    end
end
