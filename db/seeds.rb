module Seeder
  family = Family.create!(name: "The Kim Family", slogan: "The Best Family Ever!", hometown: "East Greenwich", homestate: "Rhode Island", homecountry: "USA")
  user = User.create!(first_name: "Han", last_name: "Kim", nickname: "Hanapino", admin: true, email: "hankim813@gmail.com", phone: "4012229047", address: "219 6th Street", state: "CA", country: "USA", birthday: "1991-09-13", password: "boom")
  family.users << user
  family.password = user.family.id
  family.save
end