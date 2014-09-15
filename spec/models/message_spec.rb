require 'rails_helper'

RSpec.describe Message, :type => :model do


  context "building a message" do

    subject { FactoryGirl.build(:message_with_user) }

    it { is_expected.to be_valid }

    # No empty body messages
    context "without a body" do

      subject { FactoryGirl.build(:message_with_user, {body: nil} ) }

      it { is_expected.to_not be_valid }

    end

    # Must have a user
    context "withoua a user" do

      subject { FactoryGirl.build(:message_with_user, user: nil) }

      it { is_expected.to_not be_valid }

    end

  end

  context "created with links" do

    subject { FactoryGirl.create(:message_with_links, user: FactoryGirl.create(:user)) }

    it "should have associated link objects" do
      expect(subject.links).to_not be_empty
    end
  end


  context "sending to recipients"do

    subject { FactoryGirl.create(:message_with_user) }

    it "sends the message through ActionMailer" do
      expect {subject.send_to_recipients}.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

  end

end
