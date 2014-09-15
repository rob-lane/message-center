require 'rails_helper'

RSpec.describe User, :type => :model do

  context "built" do

    subject { FactoryGirl.build(:user) }

    it { is_expected.to be_valid }

    context "with a blank email" do

      subject { FactoryGirl.build(:user, email: nil) }

      it { is_expected.to_not be_valid }

    end

    context "with an invalid email" do

      subject { FactoryGirl.build(:user, email: 'foo') }

      it { is_expected.to_not be_valid }

    end

  end

end
