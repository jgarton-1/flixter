class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson.section.course, only: [:show]
  #double check line above

  def show
   if current_lesson.section.user != current_user
      return render plain: 'Unauthorized', status: :unauthorized and redirect_to lessons_path(current_section.course)
      #double check line above, do not understand Flash message instead of unauthorized
      # redirect_to lesson_path(current_section.course), alert 'You are not enrolled in this course'
    end
  end

  private

  helper_method :current_lesson
    def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
    end
end
