FactoryBot.define do
  factory :user do
    name { "みやうち" }
    email { "aaa@gmail.com" }
    password { "123456" }
    admin { "true" }
  end
  factory :user_second,class: User do
    name { "たかはし" }
    email { "bbb@gmail.com" }
    password { "123456" }
    admin { "false" }
  end
end