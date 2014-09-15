# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url "http://foo.com"
    message { FactoryGirl.create(:message_with_user) }
  end
end
