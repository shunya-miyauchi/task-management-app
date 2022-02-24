FactoryBot.define do
  factory :task do
    title {"test_title"}
    detail {"test_detail"}
    expired_at { Time.now }
  end
end