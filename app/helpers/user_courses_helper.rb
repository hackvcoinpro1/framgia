module UserCoursesHelper
  def user_of_course course, user
    course.user_courses.find_by user_id: user.id
  end
end
