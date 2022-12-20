# Create a main sample user.
User.create!(name: "Example", surname: "User", email: "example.user@uniroma1.it", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)
    
# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.first_name
    surname = Faker::Name.last_name
    email = "example.12345#{n+1}@studenti.uniroma1.it"
    password = "password"
    User.create!(name: name, surname: surname, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

# Generate posts for a subset of users.
users = User.order(:created_at).take(6)

50.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.posts.create!(content: content) }
end
