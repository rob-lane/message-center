# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject "MyString"
    body "MyString"
    recipients {[FactoryGirl.create(:contact)]}
  end
end
