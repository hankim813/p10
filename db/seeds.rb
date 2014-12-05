module Seeder
  family = Family.create!(name: "The Kim Family", slogan: "The Best Family Ever!", hometown: "East Greenwich", homestate: "Rhode Island", homecountry: "USA")
  user = User.create!(first_name: "Han", last_name: "Kim", nickname: "Hanapino", admin: true, email: "hankim813@gmail.com", phone: "4012229047", address: "219 6th Street", state: "CA", country: "USA", birthday: "1991-09-13", password: "boom", family_key: SecureRandom.hex)
  user2 = User.create!(first_name: "Jong", last_name: "Kim", nickname: "Dad", admin: true, email: "jkim7112@gmail.com", phone: "4012229047", address: "219 6th Street", state: "CA", country: "USA", birthday: "1991-09-13", password: "boom")
  user3 = User.create!(first_name: "Helen", last_name: "Kim", nickname: "Mom", admin: true, email: "mom@gmail.com", phone: "4012229047", address: "219 6th Street", state: "CA", country: "USA", birthday: "1991-09-13", password: "boom")
  family.users << user
  family.users << user2
  family.users << user3
  family.password = user.family_key
  family.save
  user2.update_attribute(:family_key, user.family_key)
  user3.update_attribute(:family_key, user.family_key)
end