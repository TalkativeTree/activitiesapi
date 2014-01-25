# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recurrence do
    start_date "2014-01-25"
    stop_date "2014-01-25"
    pattern 1
    activity_id 1
  end
end
