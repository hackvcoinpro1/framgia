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
