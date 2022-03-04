FactoryBot.define do
  factory :label do
    name { "ラベル１" }
  end
  factory :label_second,class: Label do
    name { "ラベル２" }
  end
  factory :label_third,class: Label  do
    name { "ラベル３" }
  end
end
