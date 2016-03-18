# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Message.delete_all

User.create!(name:'ken', email:'ken.hoang87@gmail.com', password:'123', password_confirmation:'123')
10.times do |i|
  user = User.create!(name: Faker::Name.name,
      avatar_url:Faker::Avatar.image,
      email: Faker::Internet.email,
      password:'123',
      password_confirmation:'123')
end

User.all.each do |recipient|
  5.times do |i|
    message = Message.create(content: Faker::Lorem.paragraph,
      created_at:Faker::Time.between(DateTime.now - 7, DateTime.now))

    sender = User.find(rand(User.first.id..User.last.id))
    sender.sent_messages << message

    recipient.received_messages << message

  end
end

# add friends
User.all.each do |user|
  5.times do |i|
    friend = User.find(rand(User.first.id..User.last.id))
    user.friends << friend
  end
end
