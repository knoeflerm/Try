namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
    make_addresses
  end
end

def make_users
  admin = User.create!(name:     "markuk",
                       email:    "markuk@domain.country",
                       password: "mk",
                       password_confirmation: "mk")
  admin.toggle!(:admin) #FIXME: does not work for some reason
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[1..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_addresses
  users = User.all
  i = 0
  users.each do |user|
    i += 1
    name = "Name" + i.to_s
    surname = "Surname" + i.to_s
    street = "street" + i.to_s
    streetnumber = i
    zipcode = 1000 + i
    town = "Town" + i.to_s
    link = "http://www.example#{i.to_s}.com"
    phone = '+4171'  << i << i << i << i << i << i << i
    mobile = '+4178' << i << i << i << i << i << i << i 
    user.addresses.create!(name: name, surname: surname, street: street, streetnumber: streetnumber, zipcode: zipcode, town: town, link: link, phone: phone, mobile: mobile)
  end 
end