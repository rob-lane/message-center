require 'rails_helper'

RSpec.describe Contact, :type => :model do

  context "built" do

    subject { FactoryGirl.build :contact }

    it { is_expected.to be_valid }

    context "with an invalid email" do

      subject { FactoryGirl.build :contact, email: 'foo' }

      it { is_expected.to_not be_valid }

    end

    context "with no email" do

      subject { FactoryGirl.build :contact, email: nil }

      it { is_expected.to_not be_valid }

    end

  end

end
