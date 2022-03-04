# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "みやうち"
email = "aaa@gmail.com"
password = "123456"
admin = true

1.times do |n|
  User.create!(
    name: name,
    email: email,
    password: password,
    admin: admin,
  )
end

9.times do |n|
  User.create!(
    name: "#{name}#{n+1}",
    email: "#{n+1}#{email}",
    password: password,
    admin: "false",
  )
end

10.times do |n|
Label.create!(
  name: "ラベル#{n+1}",
  )
end

10.times do |n|
  User.all.each_with_index do |user,idx|
    Task.create!(
      title: "課題#{n+1}",
      detail: "どんどん進めたい#{n+1}",
      status: "着手中",
      priority: "高",
      user_id: user.id,
    )
  end
end

