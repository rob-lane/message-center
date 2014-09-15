# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'rspec@tester.com'
    password 'abc1234uandme'
  end
end
