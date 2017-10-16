require "test_helper"

class CourseSubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get course_subjects_create_url
    assert_response :success
  end

  test "should get destroy" do
    get course_subjects_destroy_url
    assert_response :success
  end
end
