FactoryBot.define do
  factory :task do
    title {"test_title"}
    detail {"test_detail"}
    expired_at { Time.now }
    status {"未着手"}
  end
  factory :task_second,class: Task do
    title {"今日"}
    detail {"いい天気"}
    expired_at { Time.now.since(3.days) }
    status {"着手中"}
  end
  factory :task_third,class: Task do
    title {"課題"}
    detail {"終わらせたい"}
    expired_at { Time.now.since(2.days) }
    status {"着手中"}
  end
end