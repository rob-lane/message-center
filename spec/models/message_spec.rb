require 'rails_helper'

RSpec.describe Message, :type => :model do


  context "creating a message" do

    subject { FactoryGirl.create(:message) }

    it { is_expected.to be_valid }

    # No empty body messages
    context "without a body" do

      subject { FactoryGirl.create(:message, {body: nil} ) }

      it { is_expected.to_not be_valid }
    end


  end

end
