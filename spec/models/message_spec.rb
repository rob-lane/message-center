require 'rails_helper'

RSpec.describe Message, :type => :model do


  context "creating a message" do

    subject { FactoryGirl.create(:message) }

    it { is_expected.to be_valid }


  end

end
