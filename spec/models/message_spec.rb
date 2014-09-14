require 'rails_helper'

RSpec.describe Message, :type => :model do


  context "building a message" do

    subject { FactoryGirl.build(:message) }

    before do
      puts subject.recipients
    end

    it { is_expected.to be_valid }

    # No empty body messages
    context "without a body" do

      subject { FactoryGirl.build(:message, {body: nil} ) }

      it { is_expected.to_not be_valid }
    end


  end

end
