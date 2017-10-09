1.upto(5) do |x|
  name = "nguyenvan#{x}"
  email = "abc#{x}@gmail.com"
  pass = User.digest "123123"
  User.create!(name: name, email: email, password_digest: pass)
end
