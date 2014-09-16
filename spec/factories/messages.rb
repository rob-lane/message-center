# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject "MyString"
    body "MyString"
    recipients {[FactoryGirl.create(:contact)]}

    factory :message_with_links, class: :message do
      subject "A test email"
      body "Checkout <a href='http://www.google.com'>google.com</a> or <a href='http://www.yahoo.com'>yahoo</a>"
      recipients {[FactoryGirl.create(:contact, email: 'rspec@tester.com')]}

      factory :message_with_nested_link do
        body "<p><a href='coolane.com'>Nested Link</a></p>"
      end
    end

    factory :message_with_user, class: :message do
      user { FactoryGirl.create(:user) }
    end
  end
end
