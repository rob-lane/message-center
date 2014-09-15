# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject "MyString"
    body "MyString"
    recipients {[FactoryGirl.create(:contact)]}
    user
  end

  factory :message_with_links, class: :message do
    subject "A test email"
    body "Checkout http://www.google.com or http://www.yahoo.com"
    recipients {[FactoryGirl.create(:contact, email: 'rspec@tester.com')]}
    user
  end
end
