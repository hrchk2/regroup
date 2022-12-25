# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

5.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      name: "テスト太郎#{n + 1}",
      password: "testtest"
    )
  end

User.create!(
   id: 99,
   email: 'guest@example.com',
   name: 'guestuser',
   password: "password"
   )

# 本番、自由参加、募集中
5.times do |n|
    Post.create!(
      user_id: n + 1,
      title: "テスト太郎#{n + 1}募集",
      body: "#testtag1 これは、ダミーです。これは、ダミーです。
これは、ダミーです。これは、ダミーです。これは、ダミーです。
これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。
これは、ダミーです。これは、ダミーです。
、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。
これは、ダミーです。これは、ダミーです。これは、ダミーです。",
      capacity: 1
    )
end

# 本番、承認制、募集中
5.times do |n|
    Post.create!(
      user_id: n + 1,
      title: "テスト太郎#{n + 1}募集",
      body: "#testtag2 これは、ダミーです。
      これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。",
      capacity: 1,
      is_free: false
    )
end

# 本番、自由参加、募集停止
5.times do |n|
    Post.create!(
      user_id: n + 1,
      title: "テスト太郎#{n + 1}募集",
      body: "#testtag3 これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。",
      capacity: 1,
      is_stop: true
    )
end

# 下書き、自由参加、募集中
5.times do |n|
    Post.create!(
      user_id: n + 1,
      title: "下書きテスト太郎#{n + 1}募集",
      body: "#testtag4 これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。",
      capacity: 1,
      status: 1
    )
end


# 本番、自由参加、募集中、キャパ０
5.times do |n|
    Post.create!(
      user_id: n + 1,
      title: "テスト太郎#{n + 1}募集",
      body: "#testtag5 #testtag6 これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。これは、ダミーです。",
    )
end


# # タグ
# 5.times do |n|
#     Tag.create!(
#       name: "tagtest#{n + 1}"
#     )
# end

# # testtag1
# 5.times do |n|
#   PostTag.create!(
#       tag_id: 1,
#       post_id: n + 1
#     )
# end

# # testtag2
# 5.times do |n|
#     PostTag.create!(
#       tag_id: 2,
#       post_id: n + 6
#     )
# end

# # testtag3
# 5.times do |n|
#     PostTag.create!(
#       tag_id: 3,
#       post_id: n + 11
#     )
# end

# # testtag4
# 5.times do |n|
#     PostTag.create!(
#       tag_id: 4,
#       post_id: n + 21
#     )
# end

# # testtag5
# 5.times do |n|
#     PostTag.create!(
#       tag_id: 5,
#       post_id: n + 21
#     )
# end