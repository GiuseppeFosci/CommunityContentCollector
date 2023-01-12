FactoryBot.define do
  
  factory :user do
    name {"Joe"}
    surname {"Green"}
    email {"joe.green@uniroma1.it"}
    password {"password"}
    password_confirmation {"password"}
  end
  
  factory :post do
    content {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec gravida tortor. Integer finibus efficitur velit consequat feugiat. Proin vitae viverra purus, vel sollicitudin sapien"}
    category {"Lettere"}
  end
end
