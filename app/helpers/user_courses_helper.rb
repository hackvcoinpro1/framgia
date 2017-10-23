module UserCoursesHelper
  def user_course_ob course, user
    course.user_courses.find_by user_id: user.id
  end

end
