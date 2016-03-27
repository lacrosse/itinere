FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test+#{n}@foremal.com" }
    password 'password'
  end

  factory :trip_plan do
    published false
    sequence(:title) { |n| "Title #{n}" }

    start_location '12, 34'
    finish_location '23, 45'
  end

  factory :trip_day do
    association :trip_plan
    date { Date.today }
  end
end
