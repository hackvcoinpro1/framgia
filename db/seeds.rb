User.create!(name: "Admin", email: "admin@gmail.com", password: "123123",
  password_confirmation: "123123", suppervisor: true)

1.upto(5) do |x|
  name = "nguyenvan#{x}"
  email = "abc#{x}@gmail.com"
  pass = User.digest "123123"
  User.create!(name: name, email: email, password_digest: pass)
end

10.times do |x|
  name = "Course Framgia OE#{x}"
  Course.create!(name: name, description: "Course description!!!")
end

arr = ["Git","Ruby","Ruby on rails 5","Scrum","PHP","Android"]
5.times do |x|
  name = arr[x]+" Tutorial"
  description = "This is description of Subject"
  Subject.create!(name: name, description: description)
end

courses = Course.order('id DESC').take(6)
subjects = Subject.all
courses.each { |c|
  id_course = c.id
  subjects.each { |s|
    id_subject = s.id
    status = 0
    date_start = Time.zone.now
    date_end = Time.zone.now + 5.day
    CourseSubject.create!( course_id: id_course,
                           subject_id: id_subject,
                           status: status,
                           date_start: date_start,
                           date_end: date_end)
  }
}
