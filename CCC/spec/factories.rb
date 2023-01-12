FactoryBot.define do
  
  factory :user do
    name {"Joe"}
    surname {"Green"}
    email {"joe.green@uniroma1.it"}
    password {"password"}
    password_confirmation {"password"}
  end
  
  trait :with_post do
    after(:create) do |user|
      create(:post, user_id: user.id)
    end
  end
  
  factory :post do
    user nil
    content {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec gravida tortor. Integer finibus efficitur velit consequat feugiat. Proin vitae viverra purus, vel sollicitudin sapien"}
    category {"Lettere"}
  end
end
